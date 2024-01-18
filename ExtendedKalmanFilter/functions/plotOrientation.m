function [truequats_ts,estquats_ts] = plotOrientation(simout,plotrate,plottypes)

    arguments
        simout
        plotrate
        plottypes.plotTrue = true
        plottypes.plotEst = false
    end

    % get data from Simulink model
    truequats_ts = simout.logsout.getElement("True Attitude (quat)").Values;
    estquats_ts = simout.logsout.getElement("Estimated Attitude (quat)").Values;
    dt = estquats_ts.Time(2)-estquats_ts.Time(1);
    [truequats_ts,estquats_ts]=synchronize(truequats_ts,estquats_ts,"Uniform","Interval",dt);
    truequats = quaternion(truequats_ts.Data);
    estquats = quaternion(estquats_ts.Data);

    % start plot
    p1 = poseplot(truequats(1));
    title("Spacecraft Attitude")
    st = subtitle("Time = "+string(truequats_ts.Time(1)));
    set(gca,"XTickLabel",[],"YTickLabel",[],"ZTickLabel",[]);

    
    if plottypes.plotTrue == true && plottypes.plotEst == false

        legend("True");
        for i = 1:plotrate:size(truequats) % Plot every "plotrate"th orientation from simulation
            set(p1,Orientation=truequats(i));
            st.String = "Time = "+compose("%.1f",truequats_ts.Time(i));
            drawnow
        end
        
    end

    if plottypes.plotTrue == true && plottypes.plotEst == true
        
        hold on; p2 = poseplot(estquats(1)); hold off;
        legend("True","Estimated");
        for i = 1:plotrate:size(truequats) % Plot every "plotrate"th orientation from simulationn
            set(p1,Orientation=truequats(i));
            set(p2,Orientation=estquats(i));
            st.String = "Time = "+compose("%.1f",truequats_ts.Time(i));
            drawnow
        end
        

    end

end