defmodule SelectMultiple.Repo.Migrations.CreateSurveys do
  use Ecto.Migration

  def change do
    create table(:surveys) do
      add :name, :string
      add :favorite_animal_select_multiple, {:array, :string}
      add :favorite_animal_checkbox_group, {:array, :string}

      timestamps()
    end
  end
end
