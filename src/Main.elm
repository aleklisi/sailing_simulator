module Main exposing (..)

import Browser
import Element exposing (..)
import Element.Border as Border
import MainBoard
import Styles exposing (..)
import Wind


type alias Model =
    { boat_direction : Int
    , boat_speed : Int
    , mainsail_angle : Int
    , wind : Wind.WindModel
    }


type Msg
    = Wind Wind.WindMsg


init : Model
init =
    { boat_direction = 0
    , boat_speed = 0
    , mainsail_angle = 0
    , wind = Wind.init
    }


update msg model =
    { model | wind = Wind.update msg model.wind }


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
                [ el
                    [ Border.width 2
                    , width fill
                    , height fill
                    ]
                    (Wind.view model.wind)
                , el
                    [ Border.width 2
                    , width fill
                    , height fill
                    ]
                    (text "mini map")
                ]
            ]
        )


main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }
