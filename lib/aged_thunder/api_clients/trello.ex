defmodule AgedThunder.ApiClients.Trello do
  def create_trello_card (ecto_changeset) do
    # TODO prefix and trello list id shoud be moved to some kind of config
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
end
