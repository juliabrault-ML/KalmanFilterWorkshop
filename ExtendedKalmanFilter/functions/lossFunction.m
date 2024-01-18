function loss = lossFunction(pc_exponent)

    process_covariance = eye(4)*exp(pc_exponent);
    in = Simulink.SimulationInput("spacecraft_model");
    in = setVariable(in,"process_covariance",process_covariance);
    out = sim(in);
    ekf_atterror_ts = out.logsout.getElement("Attitude Error (deg)").Values;
    
    % Choose a loss function
    loss = std(ekf_atterror_ts.Data);

end