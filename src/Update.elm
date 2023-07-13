module Update exposing (update)

import List.Extra
import Maybe.Extra exposing (unwrap)
import Ports
import Types exposing (Model, Msg(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        WalletsCb ws ->
            ( { model
                | walletOptions =
                    model.walletOptions
                        |> unwrap ws
                            ((++) ws)
                        |> List.sortBy .name
                        |> Just
              }
            , Cmd.none
            )

        WalletTimeout ->
            ( { model | walletTimeout = True }, Cmd.none )

        Connect ws ->
            ( { model | connectInProgress = Just ws }, Ports.connect ws )

        Disconnect closeModal ->
            ( model
            , Ports.disconnect closeModal
            )

        DisconnectIn ->
            ( { model
                | wallet = Nothing
              }
            , Cmd.none
            )

        Close ->
            ( model, Ports.close () )

        ConnectCb addr ->
            let
                wallet =
                    Maybe.map2
                        (\meta addr_ ->
                            { meta = meta
                            , address = addr_
                            }
                        )
                        (model.connectInProgress
                            |> Maybe.andThen
                                (\name ->
                                    model.walletOptions
                                        |> Maybe.withDefault []
                                        |> List.Extra.find (.name >> (==) name)
                                )
                        )
                        addr
            in
            wallet
                |> unwrap
                    ( { model
                        | connectInProgress = Nothing
                      }
                    , Cmd.none
                    )
                    (\walletAddr ->
                        ( { model
                            | wallet = Just walletAddr
                            , connectInProgress = Nothing
                          }
                        , Cmd.none
                        )
                    )
