defmodule SelectMultiple.Surveys.Survey do
  use Ecto.Schema
  import Ecto.Changeset

  schema "surveys" do
    field :name, :string
    field :favorite_animal_select_multiple, {:array, :string}
    field :favorite_animal_checkbox_group, {:array, :string}

    timestamps()
  end

  @doc false
  def changeset(survey, attrs) do
    survey
    |> cast(attrs, [:name, :favorite_animal_select_multiple, :favorite_animal_checkbox_group])
    |> validate_required([
      :name,
      :favorite_animal_select_multiple,
      :favorite_animal_checkbox_group
    ])
  end
end
