# Simple Text File

immutable Simple <: FileFormat end

%%{
    machine _simpleparser;

    action count_line { state.linenum += 1 }
    action mark       { Ragel.@anchor! }
    action line       {
        output.data = Ragel.@ascii_from_anchor!
        yield = true
        fbreak;
    }

    # name   = expression           >entering action    %leaving action
    newline  = '\r'? '\n'           >count_line;
    line     = (any - newline)+     >mark               %line;
    main    := (line newline)*;
}%%


%% write data;


type SimpleParser <: AbstractParser
    state::Ragel.State
    seqbuf::BufferedOutputStream{BufferedStreams.EmptyStreamSource}

    function SimpleParser(input::BufferedInputStream)
        %% write init;
        return new(Ragel.State(cs, input), BufferedOutputStream())
    end
end

Base.eltype(::Type{SimpleParser}) = Line

type Line
    data::ASCIIString
    Line() = new()
    Line(line) = new(line)
end

Base.convert(::Type{ASCIIString}, line::Line) = line.data

function Base.open(input::BufferedInputStream, ::Type{Simple})
    return SimpleParser(input)
end

Base.copy(line::Line) = Line(copy(line.data))

Ragel.@generate_read_fuction(
    "_simpleparser",
    SimpleParser,
    Line,
    begin
        %% write exec;
    end
)
