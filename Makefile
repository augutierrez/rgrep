# Your program must compile with 'make'
# You must not change this file.

CC = gcc
FLAGS = -std=c99 -O0 -Wall -Werror -g -pedantic

default:
	$(CC) $(FLAGS) rgrep.c matcher.c -o rgrep

clean:
	rm -f rgrep
	rm -rf *.dSYM

check:  clean default
	test "`echo "boy.text" | grep 'boy.text'`" = "boy.text"
	test "`echo "boy" | grep 'boy'`" = "boy"
	test "`echo "a\nb\nc" | grep 'a'`" = "a"
	test "`echo "a" | grep '...'`" = ""
	test "`echo "ab" | grep 'a\+b'`" = "ab"
	@echo "Passed my grep tests"
	test "`echo "n" | ./rgrep 'a?n'`" = "n"
	test "`echo "a\nb" | ./rgrep 'b'`" = "b"
	test "`echo "a\nb\nc" | ./rgrep 'a'`" = "a"
	test "`echo "a\n" | ./rgrep 'a'`" = "a"
	test "`echo "abc" | ./rgrep '...'`" = "abc"
	test "`echo "a" | ./rgrep '...'`" = ""
	test "`echo "abc" | ./rgrep '.b.'`" = "abc"
	test "`echo "h\naaaaah" | ./rgrep 'a+h'`" = "aaaaah"
	test "`echo "h\naaaaahhhhh" | ./rgrep 'aa+hh+'`" = "aaaaahhhhh"
	test "`echo "h\naaaaahhhhh\n" | ./rgrep 'aa+hh+'`" = "aaaaahhhhh"
	test "`echo "woot\nwot\nwat\n" | ./rgrep 'wo?t'`" = "wot"
	test "`echo "CCCCCCC\nC+\nC++" | ./rgrep '.\+\+'`" = "C++"
	test "`echo "GG" | ./rgrep 'G+'`" = "GG"
	test "`echo "USF_CS221.jpg" | ./rgrep 'U.F_CL?S2+1\.jpg'`" = "USF_CS221.jpg"
	test "`echo "ABBCCC" | ./rgrep 'A+B+C+'`" = "ABBCCC"
	test "`echo "RED\nREED" | ./rgrep 'RE?D'`" = "RED"
	test "`echo "TORT" | ./rgrep 'T.RT'`" = "TORT"
	test "`echo "testcase.tiff.mkv.exe" | ./rgrep 'testcase\.tiff\.mkv\.exe'`" = "testcase.tiff.mkv.exe"
	@echo "Passed sanity check."

