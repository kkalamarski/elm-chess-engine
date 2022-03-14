module Engine exposing (..)

import Array exposing (Array)
import Model exposing (Piece(..), Player(..), Square(..))


move : Int -> Int -> List Square -> List Square
move from to position =
    let
        isMoveValid =
            validateMove from to position

        positionArray =
            Array.fromList position

        fromPiece =
            Array.get from positionArray

        newPosition =
            case fromPiece of
                Just x ->
                    Array.set to x positionArray

                Nothing ->
                    positionArray
    in
    if isMoveValid then
        newPosition
            |> Array.set from EmptySquare
            |> Array.toList

    else
        position


validateMove : Int -> Int -> List Square -> Bool
validateMove from to position =
    let
        legalMoves =
            listLegalMoves from position
    in
    List.member to legalMoves


listLegalMoves : Int -> List Square -> List Int
listLegalMoves from position =
    let
        positionArray =
            Array.fromList position

        piece =
            Array.get from positionArray
    in
    case piece of
        Just p ->
            case p of
                Present color Pawn ->
                    listPawnLegalMoves color from position

                _ ->
                    []

        Nothing ->
            []


listPawnLegalMoves : Player -> Int -> List Square -> List Int
listPawnLegalMoves color from position =
    let
        positionArray =
            Array.fromList position

        possibleMoves =
            case color of
                White ->
                    if from > 63 - 16 && from < 63 - 7 then
                        [ from - 8, from - 16 ]

                    else
                        [ from - 8 ]

                Black ->
                    if from > 7 && from < 16 then
                        [ from + 8, from + 16 ]

                    else
                        [ from + 8 ]

        forwardMoves =
            possibleMoves
                |> List.filter
                    (\x ->
                        case getSquareContents x positionArray of
                            EmptySquare ->
                                True

                            _ ->
                                False
                    )

        captures =
            case color of
                White ->
                    [ from - 7, from - 9 ]

                Black ->
                    [ from + 7, from + 9 ]

        possibleCaptures =
            captures
                |> List.filter
                    (\x ->
                        case getSquareContents x positionArray of
                            EmptySquare ->
                                False

                            Present pieceColor _ ->
                                color /= pieceColor
                    )
    in
    List.concat [ forwardMoves, possibleCaptures ]


getSquareContents : Int -> Array Square -> Square
getSquareContents x array =
    Maybe.withDefault EmptySquare (Array.get x array)
