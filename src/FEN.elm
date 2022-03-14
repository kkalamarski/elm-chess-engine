module FEN exposing (..)

import Array
import Model exposing (..)


startingFEN : String
startingFEN =
    "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"


parsePosition : Maybe String -> Maybe (List Square)
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
                |> List.map lettersToSquare
    in
    Just squares


parseFen : String -> Maybe (List Square)
parseFen fen =
    let
        parts =
            String.split " " fen |> Array.fromList

        positionPart =
            parsePosition (Array.get 0 parts)
    in
    positionPart


lettersToSquare : String -> Square
lettersToSquare l =
    case l of
        "P" ->
            Present White Pawn

        "K" ->
            Present White King

        "Q" ->
            Present White Queen

        "N" ->
            Present White Knight

        "B" ->
            Present White Bishop

        "R" ->
            Present White Rook

        "p" ->
            Present Black Pawn

        "k" ->
            Present Black King

        "q" ->
            Present Black Queen

        "n" ->
            Present Black Knight

        "b" ->
            Present Black Bishop

        "r" ->
            Present Black Rook

        _ ->
            EmptySquare
