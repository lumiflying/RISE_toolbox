function [block,dictionary,static]=capture_equations(dictionary,listing,block_name,static)
if nargin<4
    static=struct();
end
function_on=false;
time_on=false;
last_status='';
fill_time='';
time_opening='';
def_flag=false;
endo_switch_flag=false;
equation=cell(2,0);
block=cell(0,1);
DELIMITERS=parser.delimiters();

chain_names={dictionary.markov_chains.name};
chain_states_number=[dictionary.markov_chains.number_of_states];
parameter_names={dictionary.parameters.name};
parameter_govern=[dictionary.parameters.governing_chain];

for ii=1:size(listing,1)
    [block,equation]=capture_equations_engine(block,listing(ii,:),block_name,equation);
end

    function [block,equation]=capture_equations_engine(block,cell_info,block_name,equation)
        
        iline_=cell_info{1};
        rawline_=cell_info{2};
        file_name_=cell_info{3};
        while ~isempty(rawline_) && ~all(isspace(rawline_))
            % try splitting first
            semicol=strfind(rawline_,';');
            if ~isempty(semicol)
                % I don't call look_around here because I need the semicol
                rest_=rawline_(1:semicol(1));
                rawline_=rawline_(semicol(1)+1:end);
            else
                rest_=rawline_;
                rawline_=[];
            end
            
            if isempty(equation)
                % % % % %                 last_status='';
                endo_switch_flag=false;
                def_flag=false;
                if time_on
                    error([mfilename,':: new equation starting without finished time index in ',file_name_,' at line ',sprintf('%0.0f',iline_)])
                end
                if function_on
                    error([mfilename,':: new equation starting with earlier function not closed in ',file_name_,' at line ',sprintf('%0.0f',iline_)])
                end
            end
            while ~isempty(rest_) && ~all(isspace(rest_))
                [tokk,rest1]=strtok(rest_,DELIMITERS);
                
                % test whether there is a declaration
                if ~isempty(tokk)
                    if (strcmp(block_name,'model') && strcmp(tokk,'model'))||...
                            (strcmp(block_name,'steady_state_model') && strcmp(tokk,'steady_state_model'))||...
                            (strcmp(block_name,'exogenous_definition') && strcmp(tokk,'exogenous_definition'))
                        while ~isempty(rest1)
                            [tokk,rest1]=strtok(rest1,DELIMITERS);
                            if ~isempty(tokk)
                                if strcmp(tokk,'linear') && strcmp(block_name,'model')
                                    dictionary.is_linear_model=true;
                                elseif strcmp(tokk,'imposed') && strcmp(block_name,'steady_state_model')
                                    static.is_imposed_steady_state=true;
                                elseif strcmp(tokk,'unique') && strcmp(block_name,'steady_state_model')
                                    static.is_unique_steady_state=true;
                                else
                                    error([mfilename,':: unknown attribute ''',tokk,''' in file ',file_name_,' at line ',sprintf('%0.0f',iline_)])
                                end
                            end
                        end
                        break % exit while ~isempty(rest_) loop
                    end
                end
                
                if ~isempty(tokk)
                    tok_status=parser.determine_status(dictionary,tokk);
                    if strcmp(tok_status,'param')
                        if strcmp(block_name,'exogenous_definition')
                            error([mfilename,':: exogenous definitions cannot contain parameters in file ',file_name_,' at line ',sprintf('%0.0f',iline_)])
                        end
                        position=strcmp(tokk,{dictionary.parameters.name});
                        dictionary.parameters(position).is_in_use=true;
                    elseif strcmp(tok_status,'x')
                        position=strcmp(tokk,{dictionary.exogenous.name});
                        dictionary.exogenous(position).is_in_use=true;
                    end
                    if strcmp(tok_status,'#')||strcmp(tok_status,'!')
                        def_flag=strcmp(tok_status,'#');
                        if strcmp(block_name,'exogenous_definition')
                            error([mfilename,':: the exogenous definition block cannot contain ''#'' or ''!'' ',file_name_,' at line ',sprintf('%0.0f',iline_)])
                        end
                        endo_switch_flag=strcmp(tok_status,'!');
                        rest_=rest1;
                        [tokk,rest1]=strtok(rest_,DELIMITERS); %#ok<*STTOK>
                        tok_status=parser.determine_status(dictionary,tokk);
                        if ~strcmp(tok_status,'unknown')
                            if strcmp(tok_status,'f')
                                disp([mfilename,':: (gentle warning): ',tokk,' is also a matlab function'])
                            else
                                error([mfilename,':: string ''',tokk,''' in ',file_name_,' at line ',sprintf('%0.0f',iline_),' cannot have multiple types'])
                            end
                        end
                        if def_flag
                            dictionary.definitions=[dictionary.definitions;{tokk}];
                        elseif endo_switch_flag
                            [istp,isdiagonal,chain_name]=parser.is_transition_probability(tokk);
                            if ~istp
                                error([mfilename,':: string ''',tokk,''' in ',file_name_,' at line ',sprintf('%0.0f',iline_),' is not an appropriate name for an endogenous switching probability'])
                            end
                            if isdiagonal
                                error([mfilename,':: "',tokk,'" is a diagonal transition probabilitiy. Only off-diagonal elements are allowed. Check ',file_name_,' at line ',sprintf('%0.0f',iline_),' is not an appropriate name for an endogenous switching probability'])
                            end
                            dictionary.time_varying_probabilities=[dictionary.time_varying_probabilities,{tokk}];
                            ch_names={dictionary.markov_chains.name};
                            loc_chain=find(strcmp(chain_name,ch_names));
                            if isempty(loc_chain)
                                error([mfilename,':: markov chain "',chain_name,'" has not be declared. In ',file_name_,' at line ',sprintf('%0.0f',iline_),' is not an appropriate name for an endogenous switching probability'])
                            end
                            chain_status=dictionary.markov_chains(loc_chain).is_endogenous;
                            if isnan(chain_status)
                                dictionary.markov_chains(loc_chain).is_endogenous=true;
                            elseif ~isequal(chain_status,true)
                                error([mfilename,':: markov chain "',chain_name,'" was previously found to be exogenous and now is endogenous. In ',file_name_,' at line ',sprintf('%0.0f',iline_),' is not an appropriate name for an endogenous switching probability'])
                            end
                        else
                            error([mfilename,':: parsing error in ',file_name_,' at line ',sprintf('%0.0f',iline_),' please report this to junior.maih@gmail.com'])
                        end
                        % update the status above
                        tok_status=parser.determine_status(dictionary,tokk);
                        if ~isempty(equation)
                            error([mfilename,':: # and ! can only occur at the beginning of an equation check in ',file_name_,' line ',sprintf('%0.0f',iline_)])
                        end
                    elseif strcmp(tok_status,'unknown')
                        error([mfilename,':: unknown string ''',tokk,''' in ',file_name_,' at line ',sprintf('%0.0f',iline_)])
                    end
                    
                    if def_flag && (strcmp(tok_status,'y')||strcmp(tok_status,'x'))
                        error([mfilename,':: definitions cannot contain variables. ',...
                            'If this is an endogenous parameter, declare the definitions as ',...
                            'parameters and use a steady state file. check ',file_name_,' at line ',sprintf('%0.0f',iline_)])
                    end
                    
                    if ~endo_switch_flag && strcmp(tok_status,'tvp')
                        error([mfilename,':: model equations cannot contain endogenous switching probabilities. check ',file_name_,' at line ',sprintf('%0.0f',iline_)])
                    end
                    left_operator=parser.look_around(tokk,rest_);
                    
                    for i1=2:length(left_operator)
                        first=parser.determine_status(dictionary,left_operator(i1-1));
                        if strcmp(first,'unknown')
                            error([mfilename,':: unknown string ''',tokk,''' in ',file_name_,' at line ',sprintf('%0.0f',iline_)])
                        end
                        second=parser.determine_status(dictionary,left_operator(i1));
                        if strcmp(second,'unknown')
                            error([mfilename,':: unknown string ''',tokk,''' in ',file_name_,' at line ',sprintf('%0.0f',iline_)])
                        end
                        check_validity([first,second],file_name_,iline_,block_name);
                    end
                    if ~isempty(left_operator)
                        if ~isempty(tokk)
                            third=parser.determine_status(dictionary,left_operator(end));
                            if strcmp(third,'unknown')
                                error([mfilename,':: unknown string ''',tokk,''' in ',file_name_,' at line ',sprintf('%0.0f',iline_)])
                            end
                            check_validity([third,tok_status],file_name_,iline_,block_name)
                        end
                        % always deal with time before dealing with
                        % functions as time potentially removes some
                        % parentheses and the functions do not.
                        if ((strcmp(last_status,'y')||strcmp(last_status,'x')) &&...
                                (strcmp(left_operator(1),'(')||strcmp(left_operator(1),'{')))% check the time
                            time_on=true;
                            time_opening=left_operator(1);
                            fill_time=[fill_time,left_operator(2:end)];
                            left_operator='';
                        elseif time_on && (strcmp(left_operator(1),')')||strcmp(left_operator(1),'}'))
                            fill_time=eval(fill_time);
                            if ~isnumeric(fill_time)||~isequal(fill_time,floor(fill_time))
                                error([mfilename,':: time syntax error in ',file_name_,' at line ',sprintf('%0.0f',iline_)])
                            end
                            equation{2,end}=fill_time;
                            update_leads_lags(equation{1,end},fill_time);
                            fill_time='';
                            time_on=false;
                            time_closing=left_operator(1);
                            if ~((strcmp(time_opening,'(') && strcmp(time_closing,')'))||...
                                    (strcmp(time_opening,'{') && strcmp(time_closing,'}')))
                                error([mfilename,':: time opened with ''',time_opening,''' and closed with ''',time_closing,''' in ',file_name_,' at line ',sprintf('%0.0f',iline_)])
                            end
                            left_operator=left_operator(2:end);
                        end
                        
                        left_parents=sum(left_operator=='(');
                        right_parents=sum(left_operator==')');
                        % try and close the function before worrying about
                        % whether the closing is not successful.
                        if function_on && right_parents
                            function_on=function_on-min(function_on,right_parents);
                        end
                        if (strcmp(last_status,'f')||function_on) && left_parents
                            function_on=function_on+left_parents;
                        end
                        if function_on<0
                            error([mfilename,':: parenthesis mismatch in ',file_name_,' at line ',sprintf('%0.0f',iline_)])
                        end
                        
                        if ~isempty(left_operator)
                            equation=[equation,{left_operator,[]}']; %#ok<*AGROW>
                        end
                    end
                    if time_on && strcmp(tok_status,'n')
                        fill_time=[fill_time,tokk];
                    else
                        equation=[equation,{tokk,[]}'];
                        if (strcmp(tok_status,'y')||strcmp(tok_status,'x'))
                            equation{2,end}=0;
                        end
                        fill_time='';
                    end
                    last_status=tok_status;
                    rest_=rest1;
                else
                    if time_on && (strcmp(rest_(1),')')||strcmp(rest_(1),'}'))
                        rest_=rest_(2:end);
                        %====================
                        fill_time=eval(fill_time);
                        if ~isnumeric(fill_time)||~isequal(fill_time,floor(fill_time))
                            error([mfilename,':: time syntax error in ',file_name_,' at line ',sprintf('%0.0f',iline_)])
                        end
                        equation{2,end}=fill_time;
                        update_leads_lags(equation{1,end},fill_time);
                        fill_time='';
                        %====================
                        time_on=false;
                    end
                    if function_on
                        left_parents=sum(rest_=='(');
                        right_parents=sum(rest_==')');
                        function_on=function_on+left_parents-min(function_on,right_parents);
                    end
                    if ~isempty(rest_)
                        equation=[equation,{rest_,[]}'];
                        rest_='';
                    end
                    last_status=parser.determine_status(dictionary,equation{1,end}(end));
                end
            end
            if ~isempty(equation)
                if strcmp(equation{1,end}(end),';')
                    % we've reach the end of the equation, validate it,
                    % load it and reinitialize.
                    equation=validate_equation(equation);
                    block=[block;{equation}];
                    equation=cell(2,0);
                end
            end
        end
        function equation=validate_equation(equation)
            checked=false;
            % look for equality signs
            equality_signs=cell(2,0);
            % the top cell with register the cell number with equality
            % sign and the lower cell, the location of the equality sign
            % within the top cell
            for ic=1:size(equation,2)
                eq_s=strfind(equation{1,ic},'=');
                if ~isempty(eq_s)
                    equality_signs=[equality_signs,transpose({ic,eq_s})];
                end
                if strcmp(block_name,'parameter_restrictions')
                    % the following restrictions must be fulfilled for the
                    % parameter restriction block
                    % 1- no variable
                    if ismember(equation{1,ic},{dictionary.orig_endogenous.name})
                        error([mfilename,':: no variable allowed in the parameter_restrictions block'])
                    end
                    % 2- if parenthesis after a parameter, then one of the elements
                    % inside the parenthesis must be a chain name and the other a
                    % numeric.
                    locs=find(strcmp(equation{1,ic},parameter_names));
                    if ~isempty(locs) % chain_states_number={dictionary.markov_chains.number_of_states};
                        nom_de_chaine=chain_names{parameter_govern(locs)};
                        etats_de_la_chaine=1:chain_states_number(parameter_govern(locs));
                        state_=1;
                        chain_='const';
                        if  ic<size(equation,2) && strcmp(equation{1,ic+1}(1),'(')
                            if strcmp(nom_de_chaine,'const')
                                error(['parameter ',equation{1,ic},' is controlled by markov chain "const". So an opening parenthesis is unexpected in ',file_name_,' at line ',sprintf('%0.0f',iline_)])
                            end
                            chain_=equation{1,ic+2};
                            if ~strcmp(chain_,nom_de_chaine) % chain
                                error(['parameter ',equation{1,ic},' is not controlled by a markov chain with name ',chain_,' in ',file_name_,' at line ',sprintf('%0.0f',iline_)])
                            end
                            if ~strcmp(equation{1,ic+3},',') % remove comma
                                error([mfilename,':: comma missing between chain and state for parameter ',equation{1,ic},' in ',file_name_,' at line ',sprintf('%0.0f',iline_)])
                            end
                            state_=eval(equation{1,ic+4});
                            if isnan(state_)||~(isnumeric(state_) && ismember(state_,etats_de_la_chaine))
                                error([mfilename,':: state invalid for parameter ',equation{1,ic},' in ',file_name_,' at line ',sprintf('%0.0f',iline_)])
                            end
                            if ~strcmp(equation{1,ic+5}(1),')') % closing parenthesis
                                error([mfilename,':: closing parenthesis missing for parameter ',equation{1,ic},' in ',file_name_,' at line ',sprintf('%0.0f',iline_)])
                            end
                            % remove all processed elements
                            equation{1,ic+1}(1)=[]; % left parenthesis
                            equation{1,ic+2}=''; % state or chain
                            equation{1,ic+3}=''; % comma
                            equation{1,ic+4}=''; % state or chain
                            equation{1,ic+5}(1)=[]; % right parenthesis
                        end
                        % we carefully record the chain and the state for
                        % later processing
                        equation{2,ic}={chain_,state_};
                    end
                    % 3- parameter must be effectively controled by the
                    % chain in the parameterization block
                end
            end
            % an equation cannot have multiple equality signs
            if size(equality_signs,2)>1
                error([mfilename,':: multiple equality signs found in ',file_name_,' at line ',sprintf('%0.0f',iline_)])
            elseif size(equality_signs,2)==1
                % validate the lhs and the rhs of the equality separately
                lhs=equation(:,1:equality_signs{1}-1);
                rhs=equation(:,equality_signs{1}+1:end);
                % split the middle cell and isolate the equality sign
                string=equation{1,equality_signs{1}};
                left_string=string(1:equality_signs{2}-1);
                right_string=string(equality_signs{2}+1:end);
                if ~isempty(left_string)
                    % add to the lhs
                    lhs=[lhs,transpose({left_string,[]})];
                end
                msg=count_parentheses(lhs(1,:));
                if ~isempty(msg)
                    error([mfilename,':: ',msg,' on left hand side in ',file_name_,' at line ',sprintf('%0.0f',iline_)])
                end
                
                if ~isempty(right_string)
                    % add to the rhs but before !
                    rhs=[transpose({right_string,[]}),rhs];
                end
                msg=count_parentheses(rhs(1,:));
                if ~isempty(msg)
                    error([mfilename,':: ',msg,' on right hand side in ',file_name_,' at line ',sprintf('%0.0f',iline_)])
                end
                checked=true;
                % Putting the equation back together: what to do with the
                % equality sign?
                if ~strcmp(block_name,'parameter_restrictions') &&...
                        ~strcmp(block_name,'steady_state_model') &&...
                        ~strcmp(block_name,'exogenous_definition') &&...
                        ~ def_flag &&... % <--- should do the same as here with TVP below
                        ~ismember(equation{1,1},dictionary.time_varying_probabilities)
                    % % % % %                         ~ismember(equation{1,1},dictionary.known_words) &&... % I don't remember why this is here !
                    % modify the last item of the right hand side
                    rhs{1,end}=[rhs{1,end}(1:end-1),');'];
                    middle=transpose({'-(',[]});
                else
                    middle=transpose({'=',[]});
                end
                equation=[lhs,middle,rhs];
            end
            if ~checked
                % then there was no equality sign and so, check the whole
                % equation in one go
                msg=count_parentheses(equation(1,:));
                if ~isempty(msg)
                    error([mfilename,':: ',msg,' in ',file_name_,' at line ',sprintf('%0.0f',iline_)])
                end
            end
            % if it is an exogenous definition equation, then it needs a
            % special treatment
            if strcmp(block_name,'exogenous_definition')
                % check that the first element on the left-hand side is an observable
                % exogenous
                vnamex=equation{1,1};
                if ~(ismember(vnamex,{dictionary.exogenous.name}) && ...
                        ismember(vnamex,{dictionary.observables.name}))
                    error([mfilename,':: ',vnamex,' must be exogenous and observed in ',file_name_,' at line ',sprintf('%0.0f',iline_)'])
                end
                % It must be dated at time 0
                if ~isequal(equation{2,1},0)
                    error([mfilename,':: ',vnamex,' must be dated at time 0 in ',file_name_,' at line ',sprintf('%0.0f',iline_)'])
                end
                % the second element must be an equality sign
                if ~strcmp(equation{1,2}(1),'=')
                    error([mfilename,':: the second token must be a ''=''  in ',file_name_,' at line ',sprintf('%0.0f',iline_)])
                end
                % no rhs variable can be dated at a time beyond 0
                for icol=3:size(equation,2)
                    if ~isempty(equation{2,icol}) && equation{2,icol}>0
                        error([mfilename,':: right-hand side variables cannot be dated in the future in ',file_name_,' at line ',sprintf('%0.0f',iline_)'])
                    end
                end
            end
            function msg=count_parentheses(equation)
                equation=cell2mat(equation);
                leftpars=numel(strfind(equation,'('));
                rightpars=numel(strfind(equation,')'));
                checked_=(leftpars==rightpars);
                leftpars=numel(strfind(equation,'['));
                rightpars=numel(strfind(equation,']'));
                checked_=checked_+2*(leftpars==rightpars);
                switch checked_
                    case 3
                        msg='';
                    case 2
                        msg='parentheses mismatch';
                    case 1
                        msg='brackets mismatch';
                    case 0
                        msg='parentheses and brackets mismatch';
                end
            end
        end
        function update_leads_lags(variable,leadorlag)
            position=find(strcmp(variable,{dictionary.orig_endogenous.name}));
            if ~isempty(position)
                dictionary.orig_endogenous(position).max_lag=min(dictionary.orig_endogenous(position).max_lag,leadorlag);
                dictionary.orig_endogenous(position).max_lead=max(dictionary.orig_endogenous(position).max_lead,leadorlag);
            else
                position=find(strcmp(variable,{dictionary.exogenous.name}));
                if ~isempty(position)
                    if leadorlag>0
                        error([mfilename,':: exogenous variable ',equation{1,end},' cannot have leads. Check ',file_name_,' at line ',sprintf('%0.0f',iline_)])
                    end
                    dictionary.exogenous(position).max_lag=min(dictionary.exogenous(position).max_lag,leadorlag);
                end
            end
        end
    end
    function check_validity(syntax,file_name_,iline_,block_name)
        good=ismember(syntax,dictionary.syntax_typical)||...
            (ismember(syntax,dictionary.syntax_time) && ~strcmp(block_name,'steady_state_model'))||...
            (ismember(syntax,dictionary.syntax_function) && function_on)||...
            (ismember(syntax,dictionary.syntax_special) && strcmp(block_name,'steady_state_model'))||...
            (ismember(syntax,dictionary.syntax_special) && strcmp(block_name,'parameter_restrictions'));
        if ~good
            error([mfilename,':: wrong syntax ',syntax,' in ',file_name_,' at line ',sprintf('%0.0f',iline_)])
        end
    end
end
