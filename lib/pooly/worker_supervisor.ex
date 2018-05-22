defmodule Pooly.WorkerSupervisor do
  use Supervisor

  #######
  # API #
  #######

  # {_,_,_} asserts that the input argument must be a three-element tuple referenced by mfa
  def start_link({_,_,_} = mfa) do
    Supervisor.start_link(__MODULE__, mfa)
  end

  #############
  # Callbacks #
  #############

  def init({m,f,a}) do

    worker_opts = [restart: :permanent,
                   function: f]

    children = [worker(m, a, worker_opts)]

    # max_restarts is 5 within max_seconds 5
    opts = [strategy: :simple_one_for_one,
            max_restarts: 5,
            max_seconds: 5]

    supervise(children, opts)

  end

end
