using Ragel
using BufferedStreams

if VERSION >= v"0.5-"
    using Base.Test
else
    using BaseTestNext
    const Test = BaseTestNext
end

testfilepath(filename) = Pkg.dir("Ragel", "test", filename)

include("simple.jl")

@testset "simple parser" begin
    lines = map(ASCIIString, open(testfilepath("simple.txt"), Simple))
    @test lines == ["foo", "bar", "baz123"]
end
