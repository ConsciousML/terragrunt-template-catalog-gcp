package tests

import (
	"os/exec"
	"testing"

	"github.com/stretchr/testify/require"
)

func TestLocalStack(t *testing.T) {
    t.Parallel()

    // Relative path containing the Terragrunt Stack to test
    stackDir := "../examples/stacks/vpc_gce"

    // Ensure destroy runs at the end, even if the test fails
    t.Cleanup(func() {
        t.Log("Running cleanup: terragrunt destroy...")
        cmdDestroy := exec.Command("terragrunt", "--non-interactive", "stack", "run", "destroy")
        cmdDestroy.Dir = stackDir
        out, err := cmdDestroy.CombinedOutput()

        t.Logf("Destroy output:\n%s", string(out))
        require.NoError(t, err, "stack run destroy failed: %s", string(out))
    })
    
    t.Log("Running: terragrunt stack generate...")
    cmdGenerate := exec.Command("terragrunt", "stack", "generate")
    cmdGenerate.Dir = stackDir
    out, err := cmdGenerate.CombinedOutput()

    t.Logf("Generate output:\n%s", string(out))
    require.NoError(t, err, "stack generate failed: %s", string(out))

    t.Log("Running: terragrunt stack run apply...")
    cmdApply := exec.Command("terragrunt", "--non-interactive", "stack", "run", "apply", "--backend-bootstrap")
    cmdApply.Dir = stackDir
    out, err = cmdApply.CombinedOutput()

    t.Logf("Apply output:\n%s", string(out))
    require.NoError(t, err, "stack run apply failed: %s", string(out))
}