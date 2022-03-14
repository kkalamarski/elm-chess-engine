module Model exposing (..)


type Player
    = White
    | Black


type Piece
    = Pawn
    | Queen
    | King
    | Knight
    | Bishop
    | Rook


type Square
    = Present Player Piece
    | EmptySquare


type Msg
    = Start (List Square)
    | Select Int
    | LoadFEN (List String)


type alias GameState =
    { position : List Square
    , selected : Maybe Int
    , legalMoves : List Int
    }


type Model
    = Idle
    | Running GameState
    | Error


init : ( Model, Cmd Msg )
init =
    ( Idle, Cmd.none )
