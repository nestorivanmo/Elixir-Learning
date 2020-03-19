defmodule Spawn4 do 
    def greet do    
        receive do 
            {sender, message} -> send sender, {:ok, "Hello, #{message}"}
            greet()
        end
    end
end

pid = spawn(Spawn4, :greet, [])
send pid, {self(), "World!"}
receive do 
    {:ok, msg} -> IO.puts msg
end

send pid, {self(), "Kermit!"}
receive do 
    {:ok, msg} -> IO.puts msg
    after 500 -> IO.puts "The greeter has gone away"
end