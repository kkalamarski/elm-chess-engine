module Tile exposing (..)

import Array
import Css
import FEN exposing (..)
import Html.Styled as Html exposing (..)
import Html.Styled.Attributes as Attr
import Html.Styled.Events exposing (..)
import Model exposing (GameState, Msg(..), Piece(..), Player(..), Square(..))
import Styles exposing (..)
import Tailwind.Utilities as Tw


styledRankText : Css.Style -> List (Html msg) -> Html msg
styledRankText shouldDisplay children =
    span
        [ Attr.css
            [ Tw.absolute
            , Tw.p_1
            , Tw.top_0
            , Tw.opacity_50
            , shouldDisplay
            ]
        ]
        children


styledFileText : Css.Style -> List (Html msg) -> Html msg
styledFileText shouldDisplay children =
    children
        |> span
            [ Attr.css
                [ Tw.absolute
                , Tw.p_1
                , Tw.right_0
                , Tw.bottom_0
                , Tw.opacity_50
                , shouldDisplay
                ]
            ]


styledTile : Css.Style -> Int -> List (Html Msg) -> Html Msg
styledTile squareColor index children =
    div
        [ Attr.css
            [ Css.height (Css.px 100)
            , Css.width (Css.px 100)
            , Tw.grid
            , Tw.items_center
            , Tw.justify_center
            , Tw.relative
            , Tw.cursor_pointer
            , squareColor
            ]
        , onClick (Select index)
        ]
        children


styledIcon : Square -> Html Msg
styledIcon t =
    let
        ( x, y ) =
            case t of
                Present White King ->
                    ( 0, 0 )

                Present White Queen ->
                    ( -100, 0 )

                Present White Bishop ->
                    ( -200, 0 )

                Present White Knight ->
                    ( -300, 0 )

                Present White Rook ->
                    ( -400, 0 )

                Present White Pawn ->
                    ( -500, 0 )

                Present Black King ->
                    ( 0, -100 )

                Present Black Queen ->
                    ( -100, -100 )

                Present Black Bishop ->
                    ( -200, -100 )

                Present Black Knight ->
                    ( -300, -100 )

                Present Black Rook ->
                    ( -400, -100 )

                Present Black Pawn ->
                    ( -500, -100 )

                _ ->
                    ( 1000, 1000 )

        shouldDisplay =
            case t of
                EmptySquare ->
                    Tw.hidden

                _ ->
                    Tw.block
    in
    div
        [ Attr.css
            [ shouldDisplay
            , Css.height (Css.px 100)
            , Css.width (Css.px 100)
            , Css.transform (Css.scale 0.9)
            ]
        , Attr.css
            [ Css.backgroundImage (Css.url "pieces.png")
            , Css.backgroundPosition2 (Css.px x) (Css.px y)
            ]
        , Attr.draggable "true"
        ]
        []


tile : GameState -> Int -> Square -> Html Msg
tile gameState index value =
    let
        isLightSquare =
            modBy 2 (index + floor (toFloat index / 8)) == 0

        isLegalMove =
            List.member index gameState.legalMoves

        squareColor =
            if isSelected then
                Tw.bg_red_600

            else if isLegalMove then
                Tw.bg_green_600

            else if isLightSquare then
                Tw.bg_blue_200

            else
                Tw.bg_blue_500

        file =
            getChessBoardFile index

        rank =
            getChessBoardRank index

        shouldDisplayRank =
            if file == "a" then
                Tw.block

            else
                Tw.hidden

        shouldDisplayFile =
            if rank == "1" then
                Tw.block

            else
                Tw.hidden

        isSelected =
            case gameState.selected of
                Just i ->
                    i == index

                Nothing ->
                    False
    in
    styledTile squareColor
        index
        [ styledFileText shouldDisplayFile [ text file ]
        , styledRankText shouldDisplayRank [ text rank ]
        , span [ Attr.css [ Tw.absolute, Tw.right_0_dot_5, Tw.top_0_dot_5, Tw.opacity_10 ] ] [ text (String.fromInt index) ]
        , span
            []
            [ styledIcon value ]
        ]



-- Util functions


getCheesBoardCoordinates : Int -> String
getCheesBoardCoordinates x =
    getChessBoardRank x ++ getChessBoardFile x


getChessBoardRank : Int -> String
getChessBoardRank x =
    String.fromInt (-(floor (toFloat x / 8)) + 8)


getChessBoardFile : Int -> String
getChessBoardFile x =
    let
        files =
            Array.fromList (String.split "" "abcdefgh")

        file =
            Array.get (modBy 8 x) files
    in
    case file of
        Just f ->
            f

        Nothing ->
            ""
