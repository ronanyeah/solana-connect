module View exposing (view)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import Html.Attributes
import Img
import Material.Icons as Icons
import Material.Icons.Types exposing (Icon)
import Maybe.Extra exposing (unwrap)
import Types exposing (..)


view : Model -> Html Msg
view model =
    [ [ [ Img.solana 25
        , text "Solana Connect"
            |> el
                [ Font.bold
                , Font.size 25
                , sansSerif
                ]
        ]
            |> row [ spacing 10 ]
      , icon Icons.close 30
            |> el [ title "Close" ]
            |> click Close
      ]
        |> row [ spaceEvenly, width fill ]
    , model.wallet
        |> unwrap
            (viewWallets model)
            (\wl ->
                [ [ "Wallet Connected:"
                        |> text
                        |> el
                            [ Font.bold
                            , Font.size 22
                            ]
                  , String.left 12 wl.address
                        |> (\addr ->
                                [ [ image
                                        [ height <| px 30
                                        , width <| px 30
                                        ]
                                        { src = wl.meta.icon
                                        , description = wl.meta.name
                                        }
                                  , text (addr ++ "...")
                                        |> el [ Font.underline ]
                                  ]
                                    |> row
                                        [ spacing 10
                                        , hover
                                        ]
                                    |> viewLink ("https://solscan.io/account/" ++ wl.address)
                                , icon Icons.content_copy 22
                                    |> el [ title "Copy" ]
                                    |> click (Copy wl.address)
                                    |> el [ mouseDown [ moveRight 3, moveDown 3 ] ]
                                ]
                                    |> row [ spacing 15 ]
                           )
                  ]
                    |> column [ spacing 10 ]
                , [ btn white "Change Wallet" (Disconnect False)
                  , btn red "Disconnect" (Disconnect True)
                  ]
                    |> wrappedRow [ spacing 20 ]
                ]
                    |> column [ spacing 40 ]
            )
    , [ text "About Solana Connect"
            |> el [ Font.size 15, Font.underline ]
      , icon Icons.open_in_new 17
      ]
        |> row [ spacing 5 ]
        |> viewLink "https://github.com/ronanyeah/solana-connect/"
        |> el [ alignRight, alignBottom ]
    ]
        |> column
            [ Background.color black
            , spacing 30
            , padding (fork model.isMobile 20 30)
            , width fill
            , Border.width 2
            , Border.color <| rgb255 84 24 158
            , Border.rounded 5
            , Font.color white
            , height fill
            ]
        |> el
            [ centerX
            , padding (fork model.isMobile 15 30)
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
            , monospace
            , Background.color <| rgba255 0 0 0 0.2
            , fadeIn
            ]


viewWallets : Model -> Element Msg
viewWallets model =
    model.walletOptions
        |> unwrap
            (spinner 20
                |> el [ centerX ]
            )
            (\ws ->
                if List.isEmpty ws then
                    [ text "No Solana wallets have been detected. "
                    , text "You can learn more about installing one "
                    , text "here"
                        |> el
                            [ Font.underline
                            ]
                        -- "https://solana.com/ecosystem/explore?categories=wallet"
                        |> viewLink "https://docs.solana.com/wallet-guide"
                    , text "."
                    ]
                        |> paragraph [ Font.center ]

                else
                    ws
                        |> List.map
                            (\w ->
                                [ [ image
                                        [ height <| px 25
                                        , width <| px 25
                                        , alignTop
                                        ]
                                        { src = w.icon
                                        , description = w.name
                                        }
                                  , [ text w.name ]
                                        |> paragraph []
                                  ]
                                    |> row [ spacing 15, width fill ]
                                , spinner 20
                                    |> el [ alignTop ]
                                    |> when (model.connectInProgress == Just w.name)
                                ]
                                    |> row
                                        [ spacing 10
                                        , hover
                                            |> whenAttr (model.connectInProgress == Nothing)
                                        , fade
                                            |> whenAttr (model.connectInProgress /= Nothing && model.connectInProgress /= Just w.name)
                                        , Font.bold
                                            |> whenAttr (model.connectInProgress == Just w.name)
                                        ]
                                    |> (if model.connectInProgress == Nothing then
                                            click (Connect w.name)

                                        else
                                            identity
                                       )
                            )
                        |> column
                            [ spacing 20
                            , height fill

                            --, heightMax 300
                            --, scrollbarY
                            ]
             --|> scrollable [ height <| px 250 ]
            )


click : msg -> Element msg -> Element msg
click msg elem =
    Input.button [ hover ]
        { onPress = Just msg
        , label = elem
        }


btn : Color -> String -> msg -> Element msg
btn col txt msg =
    Input.button
        [ padding 10
        , Border.width 1
        , Background.color col
        , Border.rounded 20
        , Font.color black
        , paddingXY 17 8
        , hover
        , Font.size 15
        ]
        { onPress = Just msg
        , label = text txt
        }


spin : Attribute msg
spin =
    style "animation" "rotation 0.7s infinite linear"


spinner : Int -> Element msg
spinner n =
    Img.notch n
        |> el
            [ spin
            , style "fill" "white"
            ]


hover : Attribute msg
hover =
    Html.Attributes.class "sc_hover_fade"
        |> htmlAttribute


fade : Attribute msg
fade =
    Html.Attributes.class "sc_fade"
        |> htmlAttribute


fadeIn : Attribute msg
fadeIn =
    style "animation" "fadeIn 0.5s"


black : Color
black =
    rgb255 0 0 0


white : Color
white =
    rgb255 255 255 255


red : Color
red =
    rgb255 255 70 60



--paddingXY x y =
--paddingWith { top = y, bottom = y, left = x, right = x }


style : String -> String -> Attribute msg
style k v =
    Html.Attributes.style k v
        |> htmlAttribute


title : String -> Attribute msg
title v =
    Html.Attributes.title v
        |> htmlAttribute


when : Bool -> Element msg -> Element msg
when cond elem =
    if cond then
        elem

    else
        none


sansSerif : Attribute msg
sansSerif =
    Font.family [ Font.sansSerif ]


monospace : Attribute msg
monospace =
    Font.family [ Font.monospace ]


viewLink : String -> Element msg -> Element msg
viewLink url elem =
    newTabLink [ hover ]
        { url = url
        , label = elem
        }


icon : Icon msg -> Int -> Element msg
icon ic n =
    ic n Material.Icons.Types.Inherit
        |> html
        |> el []


whenAttr : Bool -> Attribute msg -> Attribute msg
whenAttr bool =
    if bool then
        identity

    else
        Element.below Element.none
            |> always


fork bl a b =
    if bl then
        a

    else
        b


cappedWidth : Int -> Attribute msg
cappedWidth n =
    Element.fill |> Element.maximum n |> Element.width


cappedHeight : Int -> Attribute msg
cappedHeight n =
    Element.fill |> Element.maximum n |> Element.height
