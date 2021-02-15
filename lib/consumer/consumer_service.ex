defmodule Astreu.Consumer.Service do
  use GRPC.Server, service: Astreu.Consumer.Subscriber.Service
  require Logger
  alias Astreu.ProtocolBehaviour

  @spec subscribe(Astreu.Protocol.Message.t(), GRPC.Server.Stream.t()) ::
          Astreu.Protocol.Message.t()
  def subscribe(message_stream, stream) do
    Logger.debug("Received request #{inspect(message_stream)}")

    Enum.each(message_stream, fn message ->
      Logger.info("Decode request from #{inspect(message)}")
      handle_message(stream, message)
    end)
  end

  @spec unsubscribe(Astreu.Protocol.Message.t(), GRPC.Server.Stream.t()) ::
          Google.Protobuf.Empty.t()
  def unsubscribe(message, _stream) do
    Logger.debug("Received request #{inspect(message)}")
  end

  defp handle_message(stream, message) do
    params = %{message: message, consumer: true, producer: false}

    with {:ok, message} <- ProtocolBehaviour.ensure_metadata(params) do
      case message.data do
        {:system, _} -> ProtocolBehaviour.handle_system(stream, message.data)
        {:exchange, _} -> ProtocolBehaviour.handle_exchange(stream, message.data)
        {:ack, _} -> ProtocolBehaviour.handle_ack(stream, message.data)
        _ -> ProtocolBehaviour.handle_invalid(stream, message.data)
      end
    else
      {:error, reason} ->
        ProtocolBehaviour.handle_invalid(stream, message.data, reason)
    end
  end
end
