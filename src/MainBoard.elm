module MainBoard exposing (main)

import Angle
import Camera3d
import Color
import Direction3d
import Length
import Pixels
import Point3d
import Scene3d
import Scene3d.Material as Material
import Triangle3d
import Viewpoint3d


main =
    Scene3d.sunny
        { upDirection = Direction3d.positiveZ
        , sunlightDirection = Direction3d.positiveZ
        , shadows = True
        , dimensions = ( Pixels.pixels 1280, Pixels.pixels 720 )
        , camera = camera 1
        , clipDepth = Length.meters 1
        , background = Scene3d.backgroundColor Color.lightBlue
        , entities = [ sea, boat]
        }


axis x y z color =
    Scene3d.triangleWithShadow (Material.color color) <|
        Triangle3d.from
            (Point3d.meters x y z)
            (Point3d.meters 0 1 0)
            (Point3d.meters 1 0 0)


camera scale =
    Camera3d.perspective
        { viewpoint =
            Viewpoint3d.lookAt
                { focalPoint = Point3d.origin
                , eyePoint = Point3d.meters (-20 * scale) (20 * scale) (20 * scale)
                , upDirection = Direction3d.positiveZ
                }
        , verticalFieldOfView = Angle.degrees 90
        }


sea =
    Scene3d.quadWithShadow (Material.color Color.blue)
        (Point3d.meters -100 -100 0)
        (Point3d.meters 100 -100 0)
        (Point3d.meters 100 100 0)
        (Point3d.meters -100 100 0)


boat =
    let
        sail color =
            Scene3d.group
                [ Scene3d.triangleWithShadow (Material.color color) <|
                    Triangle3d.from
                        (Point3d.meters 2 0 1.2)
                        (Point3d.meters 2 0 4)
                        (Point3d.meters -1.5 0 1)
                , Scene3d.triangleWithShadow (Material.color color) <|
                    Triangle3d.from
                        (Point3d.meters 2.8 0 1.2)
                        (Point3d.meters 2 0 4)
                        (Point3d.meters 4 0 1)
                ]

        deck topColor sideColor =
            Scene3d.group
                [ Scene3d.triangleWithShadow (Material.color topColor) <|
                    Triangle3d.from
                        (Point3d.meters 1 1 1)
                        (Point3d.meters 1 -1 1)
                        (Point3d.meters 4 0 1)
                , Scene3d.quadWithShadow (Material.color topColor)
                    (Point3d.meters -1 -1 1)
                    (Point3d.meters 1 -1 1)
                    (Point3d.meters 1 1 1)
                    (Point3d.meters -1 1 1)
                , Scene3d.quadWithShadow (Material.color sideColor)
                    (Point3d.meters -1 -1 1)
                    (Point3d.meters -1 1 1)
                    (Point3d.meters -1 1 0)
                    (Point3d.meters -1 -1 0)
                , Scene3d.quadWithShadow (Material.color sideColor)
                    (Point3d.meters -1 -1 1)
                    (Point3d.meters 1 -1 1)
                    (Point3d.meters 1 -1 0)
                    (Point3d.meters -1 -1 0)
                , Scene3d.triangleWithShadow (Material.color sideColor) <|
                    Triangle3d.from
                        (Point3d.meters 1 -1 1)
                        (Point3d.meters 1 -1 0)
                        (Point3d.meters 4 0 1)
                , Scene3d.quadWithShadow (Material.color sideColor)
                    (Point3d.meters -1 1 1)
                    (Point3d.meters 1 1 1)
                    (Point3d.meters 1 1 0)
                    (Point3d.meters -1 1 0)
                , Scene3d.triangleWithShadow (Material.color sideColor) <|
                    Triangle3d.from
                        (Point3d.meters 1 1 1)
                        (Point3d.meters 1 1 0)
                        (Point3d.meters 4 0 1)
                ]

        lights =
            Scene3d.group
                [ point 1 1 1 Color.red
                , point 1 -1 1 Color.green
                , point -1 0 1 Color.white
                ]
    in
    Scene3d.group
        [ deck Color.lightGray Color.grey, sail Color.darkGray, lights ]

point x y z color =
    Scene3d.point { radius = Pixels.float 5 }
        (Material.color color)
        (Point3d.meters x y z)
