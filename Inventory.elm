port module Inventory exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Attributes.Aria exposing (..)
import Html.Events exposing (..)
import Html.Keyed as Keyed
import Html.Lazy exposing (lazy, lazy2)
import Json.Decode as Json
import Bootstrap.Html exposing (..)
import String

main =
  App.beginnerProgram
    { model = model
    , view = view
    , update = update
    }

-- Model

type alias Model =
  { quantity : Int
  , price : Float
  }

model : Model
model =
  Model 0 0.0

-- Update

type Msg
  = Quantity String
  | Price String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Quantity quantity ->
      let
        newInt = Result.withDefault 0 (String.toInt quantity)
      in
        { model | quantity = newInt }
    Price price ->
      let
        newFloat = Result.withDefault 0.0 (String.toFloat price)
      in
        { model | price =  newFloat }


-- View

view : Model -> Html Msg
view model =
  containerFluid_
  [
    ul [ class "list-group" ]
    [
      li [ class "list-group-item"]
      [
        row_
        [ colXs_ 3 [ input [ type' "number", placeholder "Quantity", class "form-control", onInput Quantity ] [ text <| toString model.quantity ]]
        , colXs_ 1 [ span [ class "glyphicon glyphicon-asterisk", ariaHidden True ] []]
        , colXs_ 3 [ input [ type' "number", placeholder "Price", class "form-control", step "0.1", onInput Price ] [ text <| toString model.price ]]
        , colXs_ 1 [ span [ class "glyphicon glyphicon-pause", ariaHidden True, style [("transform", "rotate(90deg)")]] []]
        , colXs_ 2 [ span [ class "badge" ] [ text (toString (toFloat(model.quantity) * model.price)) ]]
        ]
      ]
    ]
  ]
