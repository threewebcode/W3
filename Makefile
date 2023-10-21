.PHONY: commit

commit:
	# @echo "commit message:"
	@read message; \
	git add -A && \
	git commit -m "$$message" && \
	git push