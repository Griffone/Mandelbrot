defmodule ComplexNum do
    
    @moduledoc """
    A complex number library.
    """

    def new(r, i) do
        {r, i}
    end

    def add(a, b) do
        {ar, ai} = a
        {br, bi} = b
        {ar + br, ai + bi}
    end

    def sqr(x) do
        {r, i} = x
        {:math.pow(r, 2) - :math.pow(i, 2), 2 * r * i}
    end

    def abs(x) do
        {r, i} = x
        :math.sqrt(:math.pow(r, 2) + :math.pow(i, 2))
    end
end