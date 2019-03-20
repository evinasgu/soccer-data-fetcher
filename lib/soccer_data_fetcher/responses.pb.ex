defmodule AvailableResults do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          resultType: [String.t()]
        }
  defstruct [:resultType]

  field :resultType, 1, repeated: true, type: :string
end

defmodule ResultItem do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: String.t(),
          div: String.t(),
          season: String.t(),
          date: String.t(),
          home_team: String.t(),
          away_team: String.t(),
          fthg: String.t(),
          ftag: String.t(),
          ftr: String.t(),
          hthg: String.t(),
          htag: String.t(),
          htr: String.t()
        }
  defstruct [
    :id,
    :div,
    :season,
    :date,
    :home_team,
    :away_team,
    :fthg,
    :ftag,
    :ftr,
    :hthg,
    :htag,
    :htr
  ]

  field :id, 1, type: :string
  field :div, 2, type: :string
  field :season, 3, type: :string
  field :date, 4, type: :string
  field :home_team, 5, type: :string
  field :away_team, 6, type: :string
  field :fthg, 7, type: :string
  field :ftag, 8, type: :string
  field :ftr, 9, type: :string
  field :hthg, 10, type: :string
  field :htag, 11, type: :string
  field :htr, 12, type: :string
end

defmodule Result do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          Result: [ResultItem.t()]
        }
  defstruct [:Result]

  field :Result, 1, repeated: true, type: ResultItem
end
