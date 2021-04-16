SHELL := /bin/bash

initialSetup: 
	source rolling.sh;startDeployment

deployment:
	source rolling.sh;rollingDeployment

rollback:
	source rolling.sh;rollback

tearDown:
	source rolling.sh;cleanUp
