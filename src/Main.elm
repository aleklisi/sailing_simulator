module Main exposing (..)

import Boat
import Browser
import Element exposing (..)
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


update msg model =
    case msg of
        Boat.BoatMsg boatMsg ->
            ({model | boat = Boat.update boatMsg model.boat}, Cmd.none)
        Wind.WindMsg windMsg -> 
            ({model | wind = Wind.update windMsg model.wind}, Cmd.none)
        
view : Model -> Html Msg
view model =
    layout
        fillAll
        (row fillAll
            [ el
                [ Border.width 2
                , width (fillPortion 2)
                , height fill
                ]
                (Element.html MainBoard.main)
            , column
                [ Border.width 2
                , width (fillPortion 1)
                , height fill
                ]
                [ wind_view model
                , boat_view model
                ]
            ]
        )


wind_view model =
    el
        [ Border.width 2
        , width fill
        , height fill
        ]
        Wind (Wind.view model.wind)


boat_view model =
    el
        [ Border.width 2
        , width fill
        , height fill
        ]
        Boat (Boat.view model.boat)


main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }
