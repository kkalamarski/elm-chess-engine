module Styles exposing (..)

import Html exposing (Attribute, Html, div)
import Html.Attributes exposing (style)


box : List ( String, String ) -> List (Html msg) -> Html msg
box styles children =
    let
        attr =
            List.map (\( key, value ) -> Html.Attributes.style key value) styles
    in
    div attr children


display : String -> Attribute msg
display d =
    style "display" d



-- position


position : String -> Attribute msg
position d =
    style "position" d


top : String -> Attribute msg
top d =
    style "top" d


bottom : String -> Attribute msg
bottom d =
    style "bottom" d


left : String -> Attribute msg
left d =
    style "left" d


right : String -> Attribute msg
right d =
    style "right" d



-- dimensions


height : String -> Attribute msg
height h =
    style "height" h


width : String -> Attribute msg
width h =
    style "width" h



-- images


objectFit : String -> Attribute msg
objectFit h =
    style "object-fit" h


objectPosition : String -> Attribute msg
objectPosition h =
    style "object-position" h



-- transform


transform : String -> Attribute msg
transform h =
    style "transform" h



-- colors


background : String -> Attribute msg
background h =
    style "background" h


color : String -> Attribute msg
color h =
    style "color" h



-- borders


borderRadius : String -> Attribute msg
borderRadius h =
    style "border-radius" h



-- margins


margin : String -> Attribute msg
margin h =
    style "margin" h


padding : String -> Attribute msg
padding h =
    style "padding" h



-- grid


gridTemplateColumns : String -> Attribute msg
gridTemplateColumns h =
    style "grid-template-columns" h


gridTemplateRows : String -> Attribute msg
gridTemplateRows h =
    style "grid-template-rows" h


alignItems : String -> Attribute msg
alignItems h =
    style "align-items" h


justifyContent : String -> Attribute msg
justifyContent h =
    style "justify-content" h



-- fonts


fontSize : String -> Attribute msg
fontSize h =
    style "font-size" h



-- utils


overflow : String -> Attribute msg
overflow h =
    style "overflow" h


cursor : String -> Attribute msg
cursor h =
    style "cursor" h


opacity : String -> Attribute msg
opacity h =
    style "opacity" h


unit : Int -> String -> String
unit value u =
    String.fromInt value ++ u


px : Int -> String
px x =
    String.fromInt x ++ "px"
