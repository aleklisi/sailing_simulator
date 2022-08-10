module Styles exposing (colors, fillAll)

import Element exposing (..)
import Element.Border as Border


colors =
    { grey1 = rgb255 211 211 211
    , grey2 = rgb255 189 189 189
    , grey3 = rgb255 158 158 158
    , grey4 = rgb255 125 125 125
    , grey5 = rgb255 105 105 105
    }


fillAll =
    [ Border.width 2
    , width fill
    , height fill
    ]
