module Wind exposing (WindModel, WindMsg, init, update, view)

-- import Element exposing (Element, el, column, padding, spacing, text)
import Element exposing (..)
import Styles exposing (..)

import Element.Input
import Element.Background as Background
import Element.Border as Border

type alias WindModel = {
    wind_direction: Float,
    wind_speed: Float
    }

type WindMsg
    = UpdateWindDirection Float
    | UpdateWindSpeed Float

init : WindModel
init = {
    wind_direction = 0,
    wind_speed = 0
    }

update msg model =
  case msg of
     UpdateWindDirection value -> updateWindDirection value model
     UpdateWindSpeed value -> updateWindSpeed value model

updateWindDirection value model =
          { model | wind_direction = value }

updateWindSpeed value model =
          { model | wind_speed = value }

view model =
  el []
  (column [ padding 10, spacing 7 ]
    [ 
        build_input "Wind direction" 0 360 model.wind_direction UpdateWindDirection
      , build_input "Wind speed" -10 10 model.wind_speed UpdateWindSpeed
    ]
  )

build_input param_name min max current_value message_type =
    el []
    (
      Element.Input.slider
      [
          Element.height (Element.px 30)
        , Element.behindContent
          (Element.el
              [ Element.width Element.fill
              , Element.height (Element.px 2)
              , Element.centerY
              , Background.color Styles.colors.grey3
              , Border.rounded 2
              ]
              Element.none
          )
      ]
      { 
        onChange = message_type
      , label =
          Element.Input.labelAbove []
              (text param_name)
      , min = min
      , max = max
      , step = Nothing
      , value = current_value
      , thumb = Element.Input.defaultThumb
      }
    )
