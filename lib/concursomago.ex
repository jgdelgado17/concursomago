defmodule Concursomago do
  alias Resultadomago, as: Mostrar

  def puertas() do
    [
      ["X", "X", "X", "0", "0", "0", "0", 50, 100, 200] |> Enum.shuffle(),
      ["P1", "P2", "P3", "P4", "P5", "P6", "P7", "P8", "P9", "P10"],
      [false, false, false, false, false, false, false, false, false, false]
    ]
  end

  def actualizarjuego(juego, puertas, abiertas, eleccion, obtenido) do
    puertas = List.replace_at(puertas, eleccion - 1, obtenido)
    abiertas = List.replace_at(abiertas, eleccion - 1, true)
    juego = List.replace_at(juego, 1, puertas)
    juego = List.replace_at(juego, 2, abiertas)
    juego
  end

  def validareleccion(abiertas, premios, eleccion, acumulado, llantas, vacias) do
    obtenido = Enum.at(premios, eleccion - 1)

    Mostrar.mostrar_eleccion_mago(abiertas, eleccion, obtenido)

    acumulado =
      if is_integer(obtenido) and Enum.at(abiertas, eleccion - 1) == false,
        do: acumulado + obtenido,
        else: acumulado

    llantas =
      if is_bitstring(obtenido) and String.contains?(obtenido, "0") and
           Enum.at(abiertas, eleccion - 1) == false,
         do: llantas + 1,
         else: llantas

    vacias =
      if is_bitstring(obtenido) and String.contains?(obtenido, "X") and
           Enum.at(abiertas, eleccion - 1) == false,
         do: vacias + 1,
         else: vacias

    [obtenido, acumulado, llantas, vacias]
  end

  def jugar(ronda, juego, acumulado, llantas, vacias)
      when ronda > 6 or llantas >= 4 or vacias >= 3 do
    premios = Enum.at(juego, 0)
    puertas = Enum.at(juego, 1)
    Mostrar.resultado_mago(llantas, acumulado, premios, puertas)
  end

  def jugar(ronda, juego, acumulado, llantas, vacias)
      when ronda <= 6 and llantas < 4 and vacias < 3 do
    IO.puts("-------------------------------------------------------------------\n")
    IO.puts("Ronda ##{ronda} \n")

    premios = Enum.at(juego, 0)
    puertas = Enum.at(juego, 1)
    abiertas = Enum.at(juego, 2)

    IO.inspect(puertas)
    eleccion = IO.gets("\nIngresa un numero del 1 al 10 para seleccionar una puerta ==> ")
    eleccion = String.to_integer(String.trim(eleccion))

    validacion = validareleccion(abiertas, premios, eleccion, acumulado, llantas, vacias)
    obtenido = Enum.at(validacion, 0)
    acumulado = Enum.at(validacion, 1)
    llantas = Enum.at(validacion, 2)
    vacias = Enum.at(validacion, 3)

    IO.puts("\nTotal acumulado: $#{acumulado}")
    IO.puts("Llantas encontradas: #{llantas}")

    juego = actualizarjuego(juego, puertas, abiertas, eleccion, obtenido)
    jugar(ronda + 1, juego, acumulado, llantas, vacias)
  end

  def iniciarjuego do
    IO.puts("\n-------------------------CONCURSO DEL MAGO----------------------------")
    ronda = 1
    juego = puertas()
    acumulado = 0
    llantas = 0
    vacias = 0
    jugar(ronda, juego, acumulado, llantas, vacias)
  end
end
