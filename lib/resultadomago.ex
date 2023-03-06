defmodule Resultadomago do
  def resultado_mago(llantas, acumulado, premios, puertas) do
    IO.puts("-------------------------------------------------------------------\n")
    IO.puts("FIN DE LA PARTIDA")
    IO.inspect(premios, label: "Todos los premios")
    IO.inspect(puertas, label: "Premios desbloquedaos")

    if llantas == 4 do
      IO.puts("\nHas ganado el carro")
    end

    IO.puts("\nGanancia: $#{acumulado}")
  end

  def mostrar_eleccion_mago(abiertas, eleccion, obtenido) do
    if Enum.at(abiertas, eleccion - 1) do
      IO.puts("WARNING: Esta puerta ya fue abierta, ronda desperdiciada")
    else
      if is_bitstring(obtenido) and String.contains?(obtenido, "0") do
        IO.puts("Has obtenido: una llanta")
      else
        if is_integer(obtenido) do
          IO.puts("Has obtenido: $#{obtenido}")
        else
          IO.puts("Seleccionaste una puerta vacia")
        end
      end
    end
  end
end
