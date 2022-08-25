module CommonComponents exposing (..)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Input
import Styles exposing (..)

build_input param_name min max current_value message_type =
    row []
        [ el []
            (Element.Input.slider
                [ Element.height (Element.px 30)
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
                { onChange = round >> message_type
                , label =
                    Element.Input.labelAbove []
                        (text param_name)
                , min = min
                , max = max
                , step = Just 1
                , value = toFloat current_value
                , thumb = Element.Input.defaultThumb
                }
            )
        , el [] (text (String.fromInt current_value))
        ]
