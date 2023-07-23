module Main exposing (main)

import Browser
import Ports
import Types exposing (..)
import Update exposing (update)
import View exposing (view)


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( { walletOptions = Nothing
      , connectInProgress = Nothing
      , wallet = Nothing
      , walletTimeout = False
      }
    , Ports.log "start"
    )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ Ports.walletCb WalletCb
        , Ports.connectCb ConnectCb
        , Ports.walletTimeout (always WalletTimeout)
        , Ports.disconnectIn (always DisconnectIn)
        ]
