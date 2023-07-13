module Img exposing (notch, solana)

import Element exposing (Element)
import Svg exposing (Svg, linearGradient, stop, svg)
import Svg.Attributes exposing (d, fill, gradientTransform, gradientUnits, height, id, offset, stopColor, viewBox, x1, x2, y1, y2)


notch : Int -> Element msg
notch size =
    svg
        [ viewBox "0 0 512 512"
        , height <| String.fromInt size
        ]
        [ Svg.path
            [ d "M288 39.056v16.659c0 10.804 7.281 20.159 17.686 23.066C383.204 100.434 440 171.518 440 256c0 101.689-82.295 184-184 184-101.689 0-184-82.295-184-184 0-84.47 56.786-155.564 134.312-177.219C216.719 75.874 224 66.517 224 55.712V39.064c0-15.709-14.834-27.153-30.046-23.234C86.603 43.482 7.394 141.206 8.003 257.332c.72 137.052 111.477 246.956 248.531 246.667C393.255 503.711 504 392.788 504 256c0-115.633-79.14-212.779-186.211-240.236C302.678 11.889 288 23.456 288 39.056z"
            ]
            []
        ]
        |> wrap


solana : Int -> Element msg
solana size =
    svg
        [ viewBox "0 0 397.7 311.7"
        , height <| String.fromInt size
        ]
        [ linearGradient
            [ id "a"
            , x1 "360.8791"
            , x2 "141.213"
            , y1 "351.4553"
            , y2 "-69.2936"
            , gradientTransform "matrix(1 0 0 -1 0 314)"
            , gradientUnits "userSpaceOnUse"
            ]
            [ stop [ offset "0", stopColor "#00ffa3" ] [], stop [ offset "1", stopColor "#dc1fff" ] [] ]
        , Svg.path [ fill "url(#a)", d "M64.6 237.9c2.4-2.4 5.7-3.8 9.2-3.8h317.4c5.8 0 8.7 7 4.6 11.1l-62.7 62.7c-2.4 2.4-5.7 3.8-9.2 3.8H6.5c-5.8 0-8.7-7-4.6-11.1l62.7-62.7z" ] []
        , linearGradient
            [ id "b"
            , x1 "264.8291"
            , x2 "45.163"
            , y1 "401.6014"
            , y2 "-19.1475"
            , gradientTransform "matrix(1 0 0 -1 0 314)"
            , gradientUnits "userSpaceOnUse"
            ]
            [ stop [ offset "0", stopColor "#00ffa3" ] [], stop [ offset "1", stopColor "#dc1fff" ] [] ]
        , Svg.path [ fill "url(#b)", d "M64.6 3.8C67.1 1.4 70.4 0 73.8 0h317.4c5.8 0 8.7 7 4.6 11.1l-62.7 62.7c-2.4 2.4-5.7 3.8-9.2 3.8H6.5c-5.8 0-8.7-7-4.6-11.1L64.6 3.8z" ] []
        , linearGradient
            [ id "c", x1 "312.5484", x2 "92.8822", y1 "376.688", y2 "-44.061", gradientTransform "matrix(1 0 0 -1 0 314)", gradientUnits "userSpaceOnUse" ]
            [ stop [ offset "0", stopColor "#00ffa3" ] [], stop [ offset "1", stopColor "#dc1fff" ] [] ]
        , Svg.path [ fill "url(#c)", d "M333.1 120.1c-2.4-2.4-5.7-3.8-9.2-3.8H6.5c-5.8 0-8.7 7-4.6 11.1l62.7 62.7c2.4 2.4 5.7 3.8 9.2 3.8h317.4c5.8 0 8.7-7 4.6-11.1l-62.7-62.7z" ] []
        ]
        |> wrap


wrap : Svg msg -> Element msg
wrap =
    Element.html
        >> Element.el []
