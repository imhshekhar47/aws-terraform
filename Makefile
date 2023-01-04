clean:
	find . -type d -name ".terraform" -exec rm -r {} \;
	find . -type f -name "*.tfstate*" -exec rm -r {} \;