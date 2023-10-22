.PHONY: commit

commit:
	@echo "Commit message: "
	@read message; \
	git add -A && \
	git commit -m "$$message" && \
	git push