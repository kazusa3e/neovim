" syntax clear
syntax clear markdownCodeBlock
syntax clear markdownError
syntax match NotePurple /#purple/
syntax match NoteCyan /#cyan/
syntax match NoteGreen /#green/
syntax match NoteTodo /#todo/
syntax match NoteDDL /#ddl/

syntax region markdownLinkText start=/\[\[/ end=/\]\]/
