module Wind exposing (WindModel, WindMsg(..), init, update, view)

import Angle
import Axis3d
import Camera3d
import Color
import CommonComponents
import Direction3d
import Element exposing (..)
import Length
import Pixels
import Point3d
import Scene3d
import Scene3d.Material as Material
import Styles exposing (..)
import Triangle3d
import Viewpoint3d


type alias WindModel =
    { wind_direction : Int
    , wind_speed : Int
    }


type WindMsg
    = UpdateWindDirection Int
    | UpdateWindSpeed Int


init : WindModel
init =
    { wind_direction = 60
    , wind_speed = 6
    }

update msg model =
    case msg of
        UpdateWindDirection value ->
            updateWindDirection value model

        UpdateWindSpeed value ->
            updateWindSpeed value model


updateWindDirection value model =
    { model | wind_direction = value }


updateWindSpeed value model =
    { model | wind_speed = value }


view model =
    el []
        (column [ padding 10, spacing 7 ]
            [ CommonComponents.build_input "Wind direction" 0 360 model.wind_direction UpdateWindDirection
            , CommonComponents.build_input "Wind speed" -10 10 model.wind_speed UpdateWindSpeed
            , windArrow model
            ]
        )

windArrow model =
    let
        north_axis = axis 20 0 0 Color.red

        wind_direction_arrow =
            windDirectionArrow model
    in
    Element.html
        (Scene3d.unlit
            { entities =
                [ north_axis, wind_direction_arrow ]
            , camera = camera
            , clipDepth = Length.meters 1
            , background = Scene3d.transparentBackground
            , dimensions = ( Pixels.pixels 400, Pixels.pixels 400 )
            }
        )


axis x y z color =
    Scene3d.triangle (Material.color color) <|
        Triangle3d.from
            (Point3d.meters x y z)
            (Point3d.meters 0 1 -1)
            (Point3d.meters 0 -1 -1)


windDirectionArrow model =
    let
        triangle =
            Scene3d.triangle (Material.color Color.blue) <|
                Triangle3d.from
                    (Point3d.meters -1 0 0)
                    (Point3d.meters 1 0 0)
                    (Point3d.meters 0 (2 * (model.wind_speed |> toFloat)) 0)

        rotationAxis =
            Axis3d.through (Point3d.meters 0 0 0) Direction3d.z
    in
    Scene3d.rotateAround rotationAxis (Angle.degrees (toFloat model.wind_direction - 90)) triangle


camera =
    Camera3d.perspective
        { viewpoint =
            Viewpoint3d.lookAt
                { focalPoint = Point3d.origin
                , eyePoint = Point3d.meters -10 0 10
                , upDirection = Direction3d.positiveZ
                }
        , verticalFieldOfView = Angle.degrees 90
        }
