module Tile exposing (..)

import Array
import FEN exposing (..)
import Html exposing (Html, div, span, text)
import Html.Attributes
import Html.Events
import Model exposing (Msg(..))
import Styles exposing (..)
import Model exposing (Model)


styledRankText : Html.Attribute msg -> List (Html msg) -> Html msg
styledRankText shouldDisplay children =
    span
        [ position "absolute"
        , padding "5px"
        , top "0"
        , opacity "0.5"
        , shouldDisplay
        ]
        children


styledFileText : Html.Attribute msg -> List (Html msg) -> Html msg
styledFileText shouldDisplay children =
    span
        [ position "absolute"
        , padding "5px"
        , bottom "0"
        , right "0"
        , opacity "0.5"
        , shouldDisplay
        ]
        children


styledTile : String -> List (Html msg) -> Html msg
styledTile squareColor children =
    div
        [ height "100px"
        , width "100px"
        , display "grid"
        , background squareColor
        , alignItems "center"
        , justifyContent "center"
        , position "relative"
        ]
        children


styledIcon : Int -> String -> Html Msg
styledIcon i t =
    let
        ( x, y ) =
            case t of
                "K" ->
                    ( 0, 0 )

                "Q" ->
                    ( -100, 0 )

                "B" ->
                    ( -200, 0 )

                "N" ->
                    ( -300, 0 )

                "R" ->
                    ( -400, 0 )

                "P" ->
                    ( -500, 0 )

                "k" ->
                    ( 0, -100 )

                "q" ->
                    ( -100, -100 )

                "b" ->
                    ( -200, -100 )

                "n" ->
                    ( -300, -100 )

                "r" ->
                    ( -400, -100 )

                "p" ->
                    ( -500, -100 )

                _ ->
                    ( 1000, 1000 )

        shouldDisplay =
            if t == "" then
                "none"

            else
                "block"
    in
    div
        [ background (String.concat [ "url(pieces.png) no-repeat ", String.fromInt x, "px ", String.fromInt y, "px" ])
        , display shouldDisplay
        , width "100px"
        , height "100px"
        , transform "scale(0.9)"
        , cursor "pointer"
        , Html.Attributes.draggable "true"
        , Html.Events.onClick (Select (Just i))
        ]
        []


tile : Model -> Int -> String -> Html Msg
tile model index value =
    let
        isLightSquare =
            modBy 2 (index + floor (toFloat index / 8)) == 0

        squareColor =
            if isLightSquare then
                "#E7F2F8"

            else
                "#74BDCB"

        file =
            getChessBoardFile index

        rank =
            getChessBoardRank index

        shouldDisplayRank =
            if file == "a" then
                display "block"

            else
                display "none"

        shouldDisplayFile =
            if rank == "1" then
                display "block"

            else
                display "none"
    in
    styledTile squareColor
        [ styledFileText shouldDisplayFile [ text file ]
        , styledRankText shouldDisplayRank [ text rank ]
        , span
            [ color
                (if isLightSquare then
                    "black"

                 else
                    "white"
                )
            , fontSize "28px"
            ]
            [ styledIcon index value ]
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
