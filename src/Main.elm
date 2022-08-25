module Main exposing (..)

import Boat
import Browser
import Element as E
import Element.Border as Border
import Html exposing (Html)
import MainBoard
import Styles exposing (..)
import Wind


type alias Model =
    { boat : Boat.BoatModel
    , wind : Wind.WindModel
    }


type Msg
    = Wind Wind.WindMsg
    | Boat Boat.BoatMsg


init : Model
init =
    { boat = Boat.init
    , wind = Wind.init
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        Boat boatMsg ->
            {model | boat = Boat.update boatMsg model.boat}
        Wind windMsg ->
            {model | wind = Wind.update windMsg model.wind}


view : Model -> Html Msg
view model =
    E.layout
        fillAll
        (E.row fillAll
            [ E.el
                [ Border.width 2
                , E.width (E.fillPortion 2)
                , E.height E.fill
                ]
                (E.html MainBoard.main)
            , E.column
                [ Border.width 2
                , E.width (E.fillPortion 1)
                , E.height E.fill
                ]
                [ wind_view model
                , boat_view model
                ]
            ]
        )


wind_view model =
    E.el
        [ Border.width 2
        , E.width E.fill
        , E.height E.fill
        ]
        (E.map Wind (Wind.view model.wind))


boat_view model =
    E.el
        [ Border.width 2
        , E.width E.fill
        , E.height E.fill
        ]
        (E.map Boat (Boat.view model.boat))


main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }
