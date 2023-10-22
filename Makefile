.PHONY: commit

commit:
	@echo "Commit message: "
	@read message; \
	git add -A && \
	git commit -m "$$message" && \
	git push

.PHONY: github

github:
	@read -rp "Please enter your commit message: " message && \
	if [ -z "$$message" ]; then \
		echo "Commit message cannot be empty. Aborting."; \
		exit 1; \
	fi; \
	if git diff-index --quiet HEAD --; then \
		echo "No changes to commit. Aborting."; \
		exit 1; \
	fi; \
	git add -A && \
	git commit -m "$$message" && \
	if [ $$? -eq 0 ]; then \
		echo "Commit successful!"; \
		git push; \
		if [ $$? -eq 0 ]; then \
			echo "Push successful!"; \
		else \
			echo "Push failed."; \
		fi; \
	else \
		echo "Commit failed."; \
	fi
