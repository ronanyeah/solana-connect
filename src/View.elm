module View exposing (view)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Helpers.View exposing (..)
import Html exposing (Html)
import Img
import Maybe.Extra exposing (unwrap)
import Types exposing (..)


view : Model -> Html Msg
view model =
    [ [ [ Img.solana 25
        , text "Solana Connect"
            |> el [ Font.bold, Font.size 25 ]
        ]
            |> row [ spacing 10 ]
      , text "X"
            |> el [ Font.bold, Font.size 25 ]
            |> pow Close
      ]
        |> row [ spaceEvenly, width fill ]
    , model.wallet
        |> unwrap
            (viewWallets model)
            (\wl ->
                [ [ "Connected"
                        |> text
                        |> el [ Font.bold, Font.size 24, Font.italic ]
                  , String.left 12 wl.address
                        |> (\addr ->
                                newTabLink [ hover ]
                                    { url = "https://solscan.io/account/" ++ wl.address ++ "?cluster=devnet"
                                    , label =
                                        [ image [ width <| px 30 ]
                                            { src = wl.meta.icon
                                            , description = wl.meta.name
                                            }
                                        , text (addr ++ "...")
                                            |> el [ Font.underline ]
                                        ]
                                            |> row [ spacing 10 ]
                                    }
                           )
                  ]
                    |> column [ spacing 10 ]
                , [ btn "Change Wallet" (Disconnect False)
                  , btn "Disconnect" (Disconnect True)
                  ]
                    |> wrappedRow [ width fill, spaceEvenly ]
                ]
                    |> column [ spacing 30, width fill ]
            )
    ]
        |> column
            [ Background.color black
            , spacing 30
            , padding 30
            , width fill
            , Border.width 2
            , Border.color <| rgb255 84 24 158
            , Border.rounded 5
            , Font.color white
            , height fill
            ]
        |> el
            [ centerX
            , padding 30
            , cappedWidth 500
            , cappedHeight 400
            ]
        |> Element.layoutWith
            { options =
                [ Element.focusStyle
                    { borderColor = Nothing
                    , backgroundColor = Nothing
                    , shadow = Nothing
                    }
                ]
            }
            [ width fill
            , height fill
            , Background.color <| rgba255 0 0 0 0.2
            , fadeIn
            ]


viewWallets model =
    model.walletOptions
        |> unwrap
            (if model.walletTimeout then
                [ text "No Solana Wallets have been detected. "
                , text "You can learn more about installing one "
                , newTabLink [ Font.underline, hover ]
                    { url =
                        "https://docs.solana.com/wallet-guide"
                    , label = text "here"
                    }
                , text "."
                ]
                    |> paragraph [ Font.center ]

             else
                spinner 20
                    |> el [ centerX ]
            )
            (\ws ->
                if List.isEmpty ws then
                    [ "No Solana Wallets have been detected. "
                        |> text
                    , "You can learn more about installing one "
                        |> text
                    , newTabLink []
                        { url = "https://solana.com/ecosystem/explore?categories=wallet"
                        , label =
                            "here"
                                |> text
                                |> el [ Font.bold, Font.underline ]
                        }
                    , text "."
                    ]
                        |> paragraph [ Font.center ]

                else
                    ws
                        |> List.map
                            (\w ->
                                Input.button
                                    [ hover
                                        |> whenAttr (model.connectInProgress == Nothing)
                                    , fade
                                        |> whenAttr (model.connectInProgress /= Nothing && model.connectInProgress /= Just w.name)
                                    , Font.bold
                                        |> whenAttr (model.connectInProgress == Just w.name)
                                    , width fill
                                    ]
                                    { onPress =
                                        if model.connectInProgress == Nothing then
                                            Just <| Connect w.name

                                        else
                                            Nothing
                                    , label =
                                        [ [ image [ height <| px 20 ] { src = w.icon, description = "" }
                                          , text w.name
                                          ]
                                            |> row [ spacing 10 ]
                                        , spinner 20
                                            |> el [ centerY ]
                                            |> when (model.connectInProgress == Just w.name)
                                        ]
                                            |> row [ spacing 10 ]
                                    }
                            )
                        |> column
                            [ spacing 20
                            , centerX
                            , width fill
                            , height fill
                            , scrollbarY
                            ]
            )


pow msg elem =
    Input.button [ hover ]
        { onPress = Just msg
        , label = elem
        }


btn elem msg =
    Input.button
        [ padding 10
        , Border.width 1
        , Background.color white
        , Border.rounded 20
        , Font.color black
        , paddingXY 17 8
        , hover
        , Font.size 15
        ]
        { onPress = Just msg
        , label = text elem
        }


spin : Attribute msg
spin =
    style "animation" "rotation 0.7s infinite linear"


spinner : Int -> Element msg
spinner n =
    Img.notch n
        |> el [ spin, style "fill" "white" ]


hover : Attribute msg
hover =
    Element.mouseOver [ fade ]


fade : Element.Attr a b
fade =
    Element.alpha 0.6


fadeIn : Attribute msg
fadeIn =
    style "animation" "fadeIn 0.5s"


black =
    rgb255 0 0 0


white =
    rgb255 255 255 255
