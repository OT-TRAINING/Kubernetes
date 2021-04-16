SHELL := /bin/bash

initialSetup: 
	source rolling.sh;startDeployment

deployment:
	source rolling.sh;recreateDeployment

rollback:
	source rolling.sh;rollback

tearDown:
	source rolling.sh;cleanUp
