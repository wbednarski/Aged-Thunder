defmodule AgedThunder.ImageController do
  use AgedThunder.Web, :controller

  alias AgedThunder.Image

  def index(conn, _params) do
    images = Repo.all(Image)
    render(conn, "index.html", images: images)
  end

  def new(conn, _params) do
    changeset = Image.changeset(%Image{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"image" => image_params}) do
    changeset = Image.changeset(%Image{}, image_params)

    case Repo.insert(changeset) do
      {:ok, _image} ->
        create_trello_card changeset.changes
        conn
        |> put_flash(:info, "Image created successfully.")
        |> redirect(to: image_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    image = Repo.get!(Image, id)
    render(conn, "show.html", image: image)
  end

  # TOOD this probably should be moved to module
  defp create_trello_card (ecto_changeset) do
    prefix = "https://aged-thunder.s3.amazonaws.com/images/"
    trello_list_id = "57acaef3a856735b734c33b0"
    trello_key = Application.get_env(:aged_thunder, AgedThunder.Endpoint)[:trello_key]
    trello_token = Application.get_env(:aged_thunder, AgedThunder.Endpoint)[:trello_token]

    trello_payload = %{
      name: ecto_changeset.name,
      desc: ecto_changeset.desc,
      urlSource: prefix <> ecto_changeset.attachment.file_name,
      due: "null",
      idList: trello_list_id,
      key: trello_key,
      token: trello_token
    } |> Poison.encode!

    HTTPoison.post!("https://api.trello.com/1/cards", trello_payload, %{"Content-Type" => "application/json"})
  end

  # def edit(conn, %{"id" => id}) do
  #   image = Repo.get!(Image, id)
  #   changeset = Image.changeset(image)
  #   render(conn, "edit.html", image: image, changeset: changeset)
  # end
  #
  # def update(conn, %{"id" => id, "image" => image_params}) do
  #   image = Repo.get!(Image, id)
  #   changeset = Image.changeset(image, image_params)
  #
  #   case Repo.update(changeset) do
  #     {:ok, image} ->
  #       conn
  #       |> put_flash(:info, "Image updated successfully.")
  #       |> redirect(to: image_path(conn, :show, image))
  #     {:error, changeset} ->
  #       render(conn, "edit.html", image: image, changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   image = Repo.get!(Image, id)
  #
  #   # Here we use delete! (with a bang) because we expect
  #   # it to always work (and if it does not, it will raise).
  #   Repo.delete!(image)
  #
  #   conn
  #   |> put_flash(:info, "Image deleted successfully.")
  #   |> redirect(to: image_path(conn, :index))
  # end
end
