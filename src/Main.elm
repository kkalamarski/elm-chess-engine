module Main exposing (..)

import Browser
import ChessBoard exposing (chessBoard)
import Css.Global
import Engine exposing (..)
import FEN exposing (parseFen, startingFEN)
import Html as H exposing (Html)
import Html.Styled as Html
import Html.Styled.Attributes as Attr
import Html.Styled.Events exposing (onClick)
import Model exposing (Model(..), Msg(..), init)
import Tailwind.Utilities as Tw


main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }


view : Model -> Html Msg
view model =
    let
        content =
            case model of
                Running gameState ->
                    Html.div [] [ chessBoard gameState ]

                Idle ->
                    let
                        position =
                            case parseFen startingFEN of
                                Just pos ->
                                    pos

                                Nothing ->
                                    []
                    in
                    Html.div [] [ Html.button [ onClick (Start position) ] [ Html.text "Load" ] ]

                Error ->
                    Html.div [] [ Html.text "Error" ]
    in
    Html.toUnstyled <|
        Html.div
            [ Attr.css []
            ]
            [ Css.Global.global Tw.globalStyles
            , content
            ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case model of
        Running gameState ->
            case msg of
                Select i ->
                    case gameState.selected of
                        Just x ->
                            if x == i then
                                ( Running { gameState | selected = Nothing, legalMoves = [] }, Cmd.none )

                            else
                                let
                                    newPosittion =
                                        move x i gameState.position
                                in
                                ( Running { gameState | position = newPosittion, selected = Nothing, legalMoves = [] }, Cmd.none )

                        Nothing ->
                            ( Running
                                { gameState
                                    | selected = Just i
                                    , legalMoves = listLegalMoves i gameState.position
                                }
                            , Cmd.none
                            )

                _ ->
                    ( model, Cmd.none )

        Idle ->
            case msg of
                Start pos ->
                    ( Running
                        { position = pos
                        , selected = Nothing
                        , legalMoves = []
                        }
                    , Cmd.none
                    )

                _ ->
                    ( model, Cmd.none )

        Error ->
            case msg of
                _ ->
                    ( model, Cmd.none )
