function changeController(address _newController) public onlyController {
        emit ControlTransferred(controller, _newController);
        controller = _newController;
    }