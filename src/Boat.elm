module Boat exposing (BoatModel, BoatMsg(..), init, update, view)

import CommonComponents
import Element exposing (..)


type alias BoatModel =
    { x : Int
    , y : Int
    , direction : Int
    , speed : Int
    , mainsail_angle : Int
    , stere_angle : Int
    }


type BoatMsg
    = UpdateBoatX Int
    | UpdateBoatY Int
    | UpdateBoatDirection Int
    | UpdateBoatSpeed Int
    | UpdateBoatMainSailAngle Int
    | UpdateBoatStereAngle Int


init : BoatModel
init =
    { x = 0
    , y = 0
    , direction = 0
    , speed = 0
    , mainsail_angle = 0
    , stere_angle = 0
    }


update msg model =
    case msg of
        UpdateBoatX value ->
            updateBoatX value model

        UpdateBoatY value ->
            updateBoatY value model

        UpdateBoatDirection value ->
            updateBoatDirection value model

        UpdateBoatSpeed value ->
            updateBoatSpeed value model

        UpdateBoatMainSailAngle value ->
            updateBoatMainSailAngle value model

        UpdateBoatStereAngle value ->
            updateBoatStereAngle value model


updateBoatX value model =
    { model | x = value }


updateBoatY value model =
    { model | y = value }


updateBoatDirection value model =
    { model | direction = value }


updateBoatSpeed value model =
    { model | speed = value }


updateBoatMainSailAngle value model =
    { model | mainsail_angle = value }


updateBoatStereAngle value model =
    { model | stere_angle = value }


view model =
    el []
        (column [ padding 10, spacing 7 ]
            [ CommonComponents.build_input "Boat's x" -100 100 model.x UpdateBoatX
            , CommonComponents.build_input "Boat's y" -100 100 model.y UpdateBoatY
            ]
        )
