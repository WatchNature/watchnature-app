defmodule Watchnature.PhantomJS do
  @moduledoc """
  Provides helpers to automatically start PhantomJS at the beginning of a test
  and then close it when the tests have completed.
  """

  @executable "./node_modules/phantomjs-prebuilt/lib/phantom/bin/phantomjs"

  def start do
    swallow_cmd("killall phantomjs")

    port = Port.open({:spawn, "#{@executable} --wd"}, [])
    {:os_pid, os_pid} = Port.info(port, :os_pid)

    System.at_exit fn(_exit_status) ->
      swallow_cmd "kill #{os_pid}"
    end

    wait_for_phantomjs_start
  end

  defp wait_for_phantomjs_start do
    started =
      receive do
        {_port, {:data, data}} ->
          to_string(data) =~ ~r/8910/
      end

    if started do
      :ok
    else
      wait_for_phantomjs_start
    end
  end

  # Sends standard output and standard error to /dev/null,
  # preventing it from being printed to the screen.
  defp swallow_cmd(cmd) do
    "#{cmd} > /dev/null 2>&1"
    |> to_char_list
    |> :os.cmd
  end
end
