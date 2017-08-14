package out

import (
	"errors"
	"time"

	"github.com/crdant/cf-rename-resource"
)

type Command struct {
	paas PAAS
}

func NewCommand(paas PAAS) *Command {
	return &Command{
		paas: paas,
	}
}

func (command *Command) Run(request Request) (Response, error) {

	if len(request.Params.CurrentName) == 0 || len(request.Params.NewName) == 0 {
		return Response{}, errors.New("Cannot rename without the current and new application names")
	}

	err := command.paas.Login(
		request.Source.API,
		request.Source.Username,
		request.Source.Password,
		request.Source.SkipCertCheck,
	)
	if err != nil {
		return Response{}, err
	}

	err = command.paas.Target(
		request.Source.Organization,
		request.Source.Space,
	)
	if err != nil {
		return Response{}, err
	}

	command.paas.Rename(request.Params.CurrentName, request.Params.NewName)

	return Response{
		Version: resource.Version{
			Timestamp: time.Now(),
		},
		Metadata: []resource.MetadataPair{
			{
				Name:  "organization",
				Value: request.Source.Organization,
			},
			{
				Name:  "space",
				Value: request.Source.Space,
			},
		},
	}, nil
}
