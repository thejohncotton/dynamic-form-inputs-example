defmodule SelectMultipleWeb.SurveyLiveTest do
  use SelectMultipleWeb.ConnCase

  import Phoenix.LiveViewTest
  import SelectMultiple.SurveysFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_survey(_) do
    survey = survey_fixture()
    %{survey: survey}
  end

  describe "Index" do
    setup [:create_survey]

    test "lists all surveys", %{conn: conn, survey: survey} do
      {:ok, _index_live, html} = live(conn, Routes.survey_index_path(conn, :index))

      assert html =~ "Listing Surveys"
      assert html =~ survey.name
    end

    test "saves new survey", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.survey_index_path(conn, :index))

      assert index_live |> element("a", "New Survey") |> render_click() =~
               "New Survey"

      assert_patch(index_live, Routes.survey_index_path(conn, :new))

      assert index_live
             |> form("#survey-form", survey: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#survey-form", survey: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.survey_index_path(conn, :index))

      assert html =~ "Survey created successfully"
      assert html =~ "some name"
    end

    test "updates survey in listing", %{conn: conn, survey: survey} do
      {:ok, index_live, _html} = live(conn, Routes.survey_index_path(conn, :index))

      assert index_live |> element("#survey-#{survey.id} a", "Edit") |> render_click() =~
               "Edit Survey"

      assert_patch(index_live, Routes.survey_index_path(conn, :edit, survey))

      assert index_live
             |> form("#survey-form", survey: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#survey-form", survey: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.survey_index_path(conn, :index))

      assert html =~ "Survey updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes survey in listing", %{conn: conn, survey: survey} do
      {:ok, index_live, _html} = live(conn, Routes.survey_index_path(conn, :index))

      assert index_live |> element("#survey-#{survey.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#survey-#{survey.id}")
    end
  end

  describe "Show" do
    setup [:create_survey]

    test "displays survey", %{conn: conn, survey: survey} do
      {:ok, _show_live, html} = live(conn, Routes.survey_show_path(conn, :show, survey))

      assert html =~ "Show Survey"
      assert html =~ survey.name
    end

    test "updates survey within modal", %{conn: conn, survey: survey} do
      {:ok, show_live, _html} = live(conn, Routes.survey_show_path(conn, :show, survey))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Survey"

      assert_patch(show_live, Routes.survey_show_path(conn, :edit, survey))

      assert show_live
             |> form("#survey-form", survey: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#survey-form", survey: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.survey_show_path(conn, :show, survey))

      assert html =~ "Survey updated successfully"
      assert html =~ "some updated name"
    end
  end
end
