all : x86-64-by-example.pdf

rebuild :
	jupyter nbconvert --to notebook --inplace --execute --allow-errors x86-64-by-example.ipynb
	jupyter nbconvert --to notebook --inplace --execute x86-64-by-example.ipynb

x86-64-by-example.pdf : x86-64-by-example-final.ipynb
	jupyter nbconvert --to pdf $< --output $@

x86-64-by-example-final.ipynb : x86-64-by-example.ipynb
	cp $< $@
	jupyter nbconvert --to notebook --inplace --execute --allow-errors $@
	jupyter nbconvert --to notebook --inplace --execute $@
	sed \
	    -e 's/%%python -m gcc.*\\n//' \
		-e 's/%%file gcc.py.*\\n//' \
		-e 's/Overwriting gcc.py\\n//' \
		-i $@

clean :
	$(RM) x86-64-by-example.pdf x86-64-by-example-final.ipynb
