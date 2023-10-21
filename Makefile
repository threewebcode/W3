.PHONY: commit

commit:
	git add --all && git commit -m "feat: feat" && git push

.PHONY: my_target

my_target:
	@echo "Enter commit message:"
	@read message; \
	git add -A && \
	git commit -m "$$message" && \
	git push