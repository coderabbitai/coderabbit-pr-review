@{
    Severity = @('Error', 'Warning', 'Information')

    IncludeDefaultRules = $true

    IncludeRules = @(
        'PSAvoidUsingCmdletAliases',
        'PSAvoidUsingWriteHost',
        'PSAvoidUsingInvokeExpression',
        'PSAvoidUsingPlainTextForPassword',
        'PSAvoidUsingConvertToSecureStringWithPlainText',
        'PSAvoidUsingUsernameAndPasswordParams',
        'PSAvoidGlobalVars',
        'PSPossibleIncorrectComparisonWithNull',
        'PSUseDeclaredVarsMoreThanAssignments',
        'PSUseShouldProcessForStateChangingFunctions',
        'PSUseSingularNouns',
        'PSUseApprovedVerbs',
        'PSUsePSCredentialType',
        'PSReviewUnusedParameter',
        'PSProvideCommentHelp',
        'PSAvoidTrailingWhitespace',
        'PSUseConsistentIndentation',
        'PSUseConsistentWhitespace',
        'PSAvoidUsingPositionalParameters',
        'PSAvoidUsingDoubleQuotesForConstantString'
    )

    Rules = @{
        PSUseConsistentIndentation = @{
            Enable          = $true
            IndentationSize = 4
            Kind            = 'space'
        }
        PSUseConsistentWhitespace = @{
            Enable                          = $true
            CheckOpenBrace                  = $true
            CheckOpenParen                  = $true
            CheckOperator                   = $true
            CheckSeparator                  = $true
        }
        PSPlaceOpenBrace = @{
            Enable             = $true
            OnSameLine         = $true
            NewLineAfter       = $true
            IgnoreOneLineBlock = $true
        }
    }
}
