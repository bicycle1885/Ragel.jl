# Simple Text File

immutable Simple <: FileFormat end
	
const _simpleparser_start  = 2
const _simpleparser_first_final  = 2
const _simpleparser_error  = 0
const _simpleparser_en_main  = 2
const __simpleparser_nfa_targs = Int8[ 0, 0 ,  ]
const __simpleparser_nfa_offsets = Int8[ 0, 0, 0, 0 ,  ]
const __simpleparser_nfa_push_actions = Int8[ 0, 0 ,  ]
const __simpleparser_nfa_pop_trans = Int8[ 0, 0 ,  ]
type SimpleParser <: AbstractParser
	state::Ragel.State
	seqbuf::BufferedOutputStream{	BufferedStreams.EmptyStreamSource}

function SimpleParser(input::BufferedInputStream)
	begin
	cs = convert( Int , _simpleparser_start );
	
end
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
begin
if ( p == pe  )
@goto _test_eof

end
if ( cs  == 2 )
@goto st_case_2
elseif ( cs  == 1 )
@goto st_case_1
elseif ( cs  == 0 )
@goto st_case_0
end
@goto st_out
@label ctr1
begin
output.data = Ragel.@ascii_from_anchor!
yield = true
begin
p+= 1;
cs = 2;
@goto _out

end

end
begin
state.linenum += 1
end
@goto st2
@label st2
p+= 1;
if ( p == pe  )
@goto _test_eof2

end
@label st_case_2
if ( (data[1+(p )])== 10  )
begin
@goto st0

end

end
begin
@goto ctr3

end
@label ctr2
begin
output.data = Ragel.@ascii_from_anchor!
yield = true
begin
p+= 1;
cs = 1;
@goto _out

end

end
@goto st1
@label ctr3
begin
Ragel.@anchor!
end
@goto st1
@label st1
p+= 1;
if ( p == pe  )
@goto _test_eof1

end
@label st_case_1
if ( (data[1+(p )]) == 10 )
begin
@goto ctr1

end
elseif ( (data[1+(p )]) == 13 )
begin
@goto ctr2

end
end
begin
@goto st1

end
@label st_case_0
@label st0
cs = 0;
@goto _out
@label st_out
@label _test_eof2
cs = 2;
@goto _test_eof
@label _test_eof1
cs = 1;
@goto _test_eof
@label _test_eof
begin

end
@label _out
begin

end

end
end
)
