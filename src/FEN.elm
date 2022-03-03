module FEN exposing (..)

import Array
import Model exposing (..)


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
    | Empty


startingFEN : String
startingFEN =
    "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"


parsePosition : Maybe String -> Maybe (List String)
parsePosition pos =
    let
        m =
            case pos of
                Just x ->
                    x

                Nothing ->
                    ""

        ranks =
            String.split "/" m

        squares =
            List.map (\rank -> String.split "" rank) ranks
                |> List.concat
                |> List.map
                    (\x ->
                        case String.toInt x of
                            Just y ->
                                List.map (\_ -> "") (List.range 1 y)

                            Nothing ->
                                [ x ]
                    )
                |> List.concat
    in
    Just squares


parseFen : String -> Maybe (List String)
parseFen fen =
    let
        parts =
            String.split " " fen |> Array.fromList

        positionPart =
            parsePosition (Array.get 0 parts)
    in
    positionPart
