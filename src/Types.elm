module Types exposing (..)


type alias Model =
    { walletOptions : Maybe (List WalletMeta)
    , connectInProgress : Maybe String
    , wallet : Maybe Wallet
    , walletTimeout : Bool
    }


type alias Flags =
    {}


type Msg
    = WalletCb WalletMeta
    | Connect String
    | ConnectCb (Maybe String)
    | Close
    | Disconnect Bool
    | DisconnectIn
    | WalletTimeout


type alias WalletMeta =
    { name : String
    , icon : String
    }


type alias Wallet =
    { address : String
    , meta : WalletMeta
    }
